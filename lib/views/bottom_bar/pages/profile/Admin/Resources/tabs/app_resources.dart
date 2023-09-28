import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Resources/edit_resource_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../utilities/Widgets/admin/resource/admin_resource_card.dart';

class AppResources extends StatelessWidget {
  AppResources({super.key, required this.tabController});

  final searchController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  final imageController = TextEditingController();
  final categoryController = TextEditingController();

  final TabController tabController;

  _editEventDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return EditResourceDialog(
          selectedType: categoryController.text,
          categoryController: categoryController,
          tabController: tabController,
          imageController: imageController,
          idController: idController,
          nameController: nameController,
          descriptionController: descriptionController,
          linkController: linkController,
          context: context,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResourceCubit()..getAllResources(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () {
              context.read<ResourceCubit>().getAllResources();
              return Future.value();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: searchController,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        // color: const Color(0xff000000),
                      ),
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          context
                              .read<ResourceCubit>()
                              .searchResource(query: value);
                        });
                      },
                      onFieldSubmitted: (value) {
                        context
                            .read<ResourceCubit>()
                            .searchResource(query: value);
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
                                        
                                      ),
                                    ),
                                    IconButton(
                                        style: IconButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {
                                          context
                                              .read<ResourceCubit>()
                                              .getAllResources();
                                          searchController.clear();
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          size: 18,
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
                                            if (appState is ResourceDeleted) {
                                              tabController.animateTo(0);
                                            }
                                            if (appState is ResourceFetched) {
                                              categoryController.text =
                                                  appState.resource.category!;
                                              imageController.text =
                                                  appState.resource.imageUrl!;
                                              idController.text =
                                                  appState.resource.id!;
                                              nameController.text =
                                                  appState.resource.title!;
                                              // descriptionController.text =
                                              //     appState
                                              //         .resource.description!;
                                              linkController.text =
                                                  appState.resource.link!;
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return EditResourceDialog(
                                                    selectedType:
                                                        categoryController.text,
                                                    categoryController:
                                                        categoryController,
                                                    tabController:
                                                        tabController,
                                                    imageController:
                                                        imageController,
                                                    idController: idController,
                                                    nameController:
                                                        nameController,
                                                    descriptionController:
                                                        descriptionController,
                                                    linkController:
                                                        linkController,
                                                    context: context,
                                                  );
                                                },
                                              );
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
                                                return AdminResourceCard(
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
                                                  function: () async {
                                                    BlocProvider.of<
                                                                ResourceCubit>(
                                                            context)
                                                        .getResourceById(
                                                            id: state
                                                                    .resources[
                                                                        index]
                                                                    .id ??
                                                                "");
                                                  },
                                                  completeFunction: () {
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
