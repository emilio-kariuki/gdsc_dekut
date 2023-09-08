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
          backgroundColor: Colors.white,
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
                    Container(
                      height: 49,
                      padding: const EdgeInsets.only(left: 15, right: 1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.grey[500]!,
                            width: 0.8,
                          )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.search,
                            color: Color(0xff666666),
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: searchController,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color(0xff000000),
                              ),
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  context
                                      .read<ResourceCubit>()
                                      .searchUnApprovedResources(
                                          query: value.toLowerCase());
                                } else {
                                  context
                                      .read<ResourceCubit>()
                                      .getUnApprovedResources();
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Search for event eg. Flutter",
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xff666666),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                                        color: const Color(0xff000000),
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
                                        icon: const Icon(
                                          Icons.close,
                                          size: 18,
                                          color: Colors.black,
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
                                                  about: state.resources[index]
                                                          .description ??
                                                      "",
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
