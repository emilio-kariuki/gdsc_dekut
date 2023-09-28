import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/approve_resource_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ApprovedResources extends StatelessWidget {
  ApprovedResources({super.key, required this.tabController});

  final searchController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final imageController = TextEditingController();

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ResourceCubit()..getUnApprovedResources()),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              context.read<ResourceCubit>().getUnApprovedResources();
              return Future.value();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResourceSearchContainer(searchController: searchController),
                    BlocListener<ResourceCubit, ResourceState>(
                      listener: (context, state) {
                        if (state is ResourceError) {
                          Timer(
                            const Duration(milliseconds: 300),
                            () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xffEB5757),
                                content: Text(state.message),
                              ),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<ResourceCubit, ResourceState>(
                        builder: (context, state) {
                          if (state is ResourceLoading) {
                            return SizedBox(
                              height: height * 0.65,
                              child: const Center(
                                child: LoadingCircle(),
                              ),
                            );
                          } else if (state is ResourceSuccess) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Search Results",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        
                                      ),
                                    ),
                                    IconButton(
                                        style: IconButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<ResourceCubit>()
                                              .getUnApprovedResources();
                                          searchController.clear();
                                        },
                                        icon:  Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Theme.of(context).iconTheme.color
                                        ))
                                  ],
                                ),
                                state.resources.isEmpty
                                    ? SizedBox(
                                        height: height * 0.5,
                                        child: Center(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(AppImages.oops,
                                                height: height * 0.2),
                                            Text(
                                              "Search not found",
                                              style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: const Color(0xff666666),
                                              ),
                                            ),
                                          ],
                                        )),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: BlocConsumer<ResourceCubit,
                                            ResourceState>(
                                          listener: (context, appState) {
                                            if (state is ResourceApproved) {
                                              tabController.animateTo(0);
                                            }

                                            if (state is ResourceDeleted) {
                                              tabController.animateTo(1);
                                            }
                                          },
                                          builder: (context, appState) {
                                            return ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: state.resources.length,
                                              itemBuilder: (context, index) {
                                                return AdminApprovedResourceCard(
                                                  category: state
                                                          .resources[index]
                                                          .category ??
                                                      "",
                                                  id: state.resources[index]
                                                          .id ??
                                                      "",
                                                  width: width,
                                                  height: height,
                                                  title: state.resources[index]
                                                          .title ??
                                                      "",
                                                  // about: state.resources[index]
                                                  //         .description ??
                                                  //     "",
                                                  link: state.resources[index]
                                                          .link ??
                                                      "",
                                                  image: state.resources[index]
                                                          .imageUrl ??
                                                      AppImages.eventImage,
                                                  editFunction: () async {
                                                    BlocProvider.of<
                                                                ResourceCubit>(
                                                            context)
                                                        .deleteResource(
                                                            id: state
                                                                    .resources[
                                                                        index]
                                                                    .id ??
                                                                "");
                                                  },
                                                  approveFunction: () {
                                                    BlocProvider.of<
                                                                ResourceCubit>(
                                                            context)
                                                        .approveResource(
                                                            id: state
                                                                    .resources[
                                                                        index]
                                                                    .id ??
                                                                "");
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      )
                              ],
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ResourceSearchContainer extends StatelessWidget {
  const ResourceSearchContainer({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        // 
      ),
      onChanged: (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          context
              .read<ResourceCubit>()
              .searchUnApprovedResources(query: value);
        });
      },
      onFieldSubmitted: (value) {
        context
            .read<ResourceCubit>()
            .searchUnApprovedResources(query: value);
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xff666666),
          size: 18,
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<ResourceCubit>()..getAllResources();
            searchController.clear();
          },
          icon: const Icon(
            Icons.close,
            color: Color(0xff666666),
            size: 18,
          ),
        ),
        hintText: "Search for resource eg. Flutter",
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey[500]!,
            width: 1.3,
          ),
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          // color: const Color(0xff666666),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
