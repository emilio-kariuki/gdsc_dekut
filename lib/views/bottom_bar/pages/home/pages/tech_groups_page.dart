import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/group/group_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/group_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';

import '../../../../../data/services/providers/app_providers.dart';

class TechGroupsPage extends StatelessWidget {
  TechGroupsPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => GroupCubit()..getAllGroups(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: Text(
                "Tech Groups",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(
                    const Duration(seconds: 1),
                    () {
                      context.read<GroupCubit>().getAllGroups();
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //           height: 20,
                    //         ),
                    SearchContainer(
                        searchController: searchController,
                        onChanged: (value) {
                          context.read<GroupCubit>().searchGroup(query: value);
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          context.read<GroupCubit>().searchGroup(query: value);
                          return null;
                        },
                        hint: "Search for group eg. GDSC",
                        close: () {
                          context.read<GroupCubit>().getAllGroups();
                          searchController.clear();
                        }),
                    const SizedBox(
                      height: 10,
                    ),

                    BlocConsumer<GroupCubit, GroupState>(
                      listener: (context, state) {
                        if (state is GroupError) {
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
                        if (state is GroupLoading) {
                          return SizedBox(
                            height: height * 0.65,
                            child: const Center(
                              child: LoadingCircle(),
                            ),
                          );
                        } else if (state is GroupSuccess) {
                          return Column(
                            children: [
                              SearchResultButton(
                                function: () {
                                  context.read<GroupCubit>().getAllGroups();
                                  searchController.clear();
                                },
                              ),
                              state.groups.isEmpty
                                  ? SearchNotFound()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 8,
                                                childAspectRatio: 0.75,
                                                mainAxisSpacing: 5),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state.groups.length,
                                        itemBuilder: (context, index) {
                                          return Semantics(
                                            button: true,
                                            child: InkWell(
                                              onTap: () async {
                                                await AppProviders().openLink(
                                                    link: state
                                                        .groups[index].link!);
                                              },
                                              child: GroupContainer(
                                                height: height,
                                                width: width,
                                                image: state.groups[index]
                                                        .imageUrl ??
                                                    AppImages.eventImage,
                                                title:
                                                    state.groups[index].title ??
                                                        "Group Name",
                                                link: state.groups[index].link!,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
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
