import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';

import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../utilities/Widgets/admin_resource_card.dart';
import '../../../../../../../utilities/Widgets/search_not_found.dart';
import '../../../../../../../utilities/Widgets/search_result_button.dart';

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
                                              isApproved: true,
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
