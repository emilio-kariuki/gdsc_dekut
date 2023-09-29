import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';

class MoreResourcesPage extends StatelessWidget {
  MoreResourcesPage({super.key, required this.title, required this.category});

  final String title;
  final String category;

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          ResourceCubit()..getResourcesByCategory(category: category),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium
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
                    SearchContainer(
                        searchController: searchController,
                        onChanged: (value) {
                          context
                              .read<ResourceCubit>()
                              .searchResourceByCategory(
                                query: value,
                                category: category,
                              );
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          context
                              .read<ResourceCubit>()
                              .searchResourceByCategory(
                                query: value,
                                category: category,
                              );
                          return null;
                        },
                        hint: "Search for resource eg. Flutter",
                        close: () {
                          context
                              .read<ResourceCubit>()
                              .getResourcesByCategory(category: category);
                          searchController.clear();
                        }),
                    SizedBox(
                      height: height * 0.02,
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
                                SearchResultButton(
                                  function: () {
                                    context
                                        .read<ResourceCubit>()
                                        .getResourcesByCategory(
                                            category: category);
                                    searchController.clear();
                                  },
                                ),
                                state.resources.isEmpty
                                    ? SearchNotFound()
                                    : GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.7,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 8,
                                        ),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.resources.length,
                                        itemBuilder: (context, index) {
                                          return ResourceCard(
                                            resource: state.resources[index],
                                          );
                                        },
                                      ),
                              ],
                            );
                          } else {
                            return SearchNotFound();
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
