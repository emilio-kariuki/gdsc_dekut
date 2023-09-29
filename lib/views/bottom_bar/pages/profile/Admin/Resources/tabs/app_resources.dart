import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';

import '../../../../../../../utilities/Widgets/admin_resource_card.dart';

class AppResources extends StatelessWidget {
  AppResources({super.key, required this.tabController});

  final searchController = TextEditingController();


  final TabController tabController;


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                    SearchContainer(
                      searchController: searchController,
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          context
                              .read<ResourceCubit>()
                              .searchResource(query: value);
                        });
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        context
                            .read<ResourceCubit>()
                            .searchResource(query: value);
                        return null;
                      },
                      hint: "Search for resource eg. Flutter",
                      close: () {
                        context.read<ResourceCubit>()..getAllResources();
                        searchController.clear();
                      },
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
                                        .getAllResources();
                                    searchController.clear();
                                  },
                                ),
                                state.resources.isEmpty
                                    ? SearchNotFound()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.resources.length,
                                          itemBuilder: (context, index) {
                                            return AdminResourceCard(
                                              resource: state.resources[index],
                                              isApproved: false,
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
