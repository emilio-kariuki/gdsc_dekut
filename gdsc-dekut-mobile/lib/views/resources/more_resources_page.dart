import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MoreResourcesPage extends StatelessWidget {
  MoreResourcesPage({super.key, required this.title, required this.category});

  final String title;
  final String category;

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) =>
          ResourceCubit()..getResourcesByCategory(category: category),
      child: Builder(builder: (context) {
        return Scaffold(
          // backgroundColor: Colors.white,
          appBar: AppBar(
            // backgroundColor: Colors.white,
            title: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context
                          .read<ResourceCubit>()
                          .getResourcesByCategory(category: category);
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 49,
                      padding: const EdgeInsets.only(left: 15, right: 1),
                      decoration: BoxDecoration(
                          // color: Colors.white,
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
                            // color: Color(0xff666666),
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
                                context
                                    .read<ResourceCubit>()
                                    .searchResourceByCategory(
                                      query: value,
                                      category: category,
                                    );
                              },
                              decoration: InputDecoration(
                                hintText: "Search for resource eg. Flutter",
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
                    const SizedBox(
                      height: 7,
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
                                              .getResourcesByCategory(
                                                  category: category);
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
                                    : GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 2,
                                                crossAxisSpacing: 8),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.resources.length,
                                        itemBuilder: (context, index) {
                                          return ResourceCard(
                                              link:
                                                  state.resources[index].link!,
                                              description: state
                                                  .resources[index]
                                                  .description!,
                                              category: state
                                                  .resources[index].category!,
                                              width: width,
                                              height: height,
                                              image: state
                                                  .resources[index].imageUrl!,
                                              title: state
                                                  .resources[index].title!);
                                        },
                                      ),
                              ],
                            );
                          } else {
                            return BlocConsumer<ResourceCubit, ResourceState>(
                               listener: (context, state) {
                                if (state is ResourceError) {
                                  Timer(
                                    const Duration(milliseconds: 300),
                                    () => ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor:
                                            const Color(0xffEB5757),
                                        content: Text(state.message),
                                      ),
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is ResourceLoading) {
                                  return SizedBox(
                                      height: height * 0.65,
                                      child: const Center(
                                          child: LoadingCircle()));
                                } else if (state is ResourceSuccess) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: state.resources.isEmpty
                                        ? SizedBox(
                                            height: height * 0.7,
                                            child: Center(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(AppImages.oops,
                                                    height: height * 0.2),
                                                Text(
                                                  "Resources not found",
                                                  style: GoogleFonts.inter(
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    fontSize: 15,
                                                    color: const Color(
                                                        0xff666666),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          )
                                        : GridView.builder(
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    childAspectRatio: 0.7,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 8),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state.resources.length,
                                            itemBuilder: (context, index) {
                                              return ResourceCard(
                                                  link: state
                                                      .resources[index].link!,
                                                  description: state
                                                      .resources[index]
                                                      .description!,
                                                  category: state
                                                      .resources[index]
                                                      .category!,
                                                  width: width,
                                                  height: height,
                                                  image: state
                                                      .resources[index]
                                                      .imageUrl!,
                                                  title: state
                                                      .resources[index]
                                                      .title!);
                                            },
                                          ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            );
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
