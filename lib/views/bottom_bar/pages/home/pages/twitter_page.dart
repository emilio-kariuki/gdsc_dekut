import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';
import 'package:gdsc_bloc/utilities/Widgets/twitter_card.dart';

class TwitterPage extends StatelessWidget {
  TwitterPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => TwitterSpaceCubit()..getAllTwitterSpaces(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Twitter Spaces",
              style: Theme.of(context).textTheme.titleMedium,
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
                      context.read<TwitterSpaceCubit>().getAllTwitterSpaces();
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
                        if (value.isNotEmpty) {
                          context
                              .read<TwitterSpaceCubit>()
                              .searchTwitterSpace(queyr: value);
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<TwitterSpaceCubit>()
                              .searchTwitterSpace(queyr: value);
                        }
                        return null;
                      },
                      hint: "Search space eg. flutter",
                      close: () {
                        context.read<TwitterSpaceCubit>().getAllTwitterSpaces();
                        searchController.clear();
                      },
                    ),
                    BlocConsumer<TwitterSpaceCubit, TwitterSpaceState>(
                      listener: (context, state) {
                        if (state is TwitterSpaceError) {
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
                      builder: (context, state) {
                        if (state is TwitterSpaceLoading) {
                          return SizedBox(
                            height: height * 0.65,
                            child: const Center(
                              child: LoadingCircle(),
                            ),
                          );
                        } else if (state is TwitterSpaceSuccess) {
                          return Column(
                            children: [
                              SearchResultButton(
                                function: () {
                                  context
                                      .read<TwitterSpaceCubit>()
                                      .getAllTwitterSpaces();
                                  searchController.clear();
                                },
                              ),
                              state.spaces.isEmpty
                                  ? SearchNotFound()
                                  : GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 4,
                                        childAspectRatio: 0.65,
                                      ),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: state.spaces.length,
                                      itemBuilder: (context, index) {
                                        return TwitterCard(
                                          twitter: state.spaces[index],
                                        );
                                      },
                                    ),
                            ],
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
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
