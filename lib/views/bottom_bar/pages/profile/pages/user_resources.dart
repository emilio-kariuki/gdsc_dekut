import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gdsc_bloc/utilities/Widgets/group_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../../blocs/app_functionality/resource/resource_cubit.dart';

class UserResources extends StatelessWidget {
  UserResources({super.key});

  final searchController = TextEditingController();

  void _showBottomSheet(BuildContext context, {required String id}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return BlocProvider(
          create: (context) => ResourceCubit(),
          child: Builder(builder: (context) {
            return Container(
              width: width,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: height * 0.06,
                      width: width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            enableFeedback: false,
                            foregroundColor: Colors.grey,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Colors.grey[500]!,
                                  width: 0.5,
                                ))),
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: Text(
                          "Edit",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  BlocListener<ResourceCubit, ResourceState>(
                    listener: (context, state) {
                      if (state is ResourceDeleted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            content:
                                const Text("Resource Deleted Successfully")));
                      }

                      if (state is ResourceError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            content: Text(state.message)));
                      }
                    },
                    child: Expanded(
                      child: SizedBox(
                        height: height * 0.06,
                        width: width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.grey,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.grey[500]!,
                                    width: 0.5,
                                  ))),
                          onPressed: () {
                            Navigator.pop(context);
                            BlocProvider.of<ResourceCubit>(context)
                                .deleteResource(id: id);
                          },
                          child: Text(
                            "Delete",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
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
          create: (context) => ResourceCubit()..getUserResources(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
            title: Text(
              "User Resources",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff666666),
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
                      context.read<ResourceCubit>().getUserResources();
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
                          if (value.isNotEmpty) {
                            context
                                .read<ResourceCubit>()
                                .searchUserResource(query: value);
                          } else {
                            context.read<ResourceCubit>().getUserResources();
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            context
                                .read<ResourceCubit>()
                                .searchUserResource(query: value);
                          } else {
                            context.read<ResourceCubit>().getUserResources();
                          }
                          return null;
                        },
                        hint: "Search for resource eg.flutter",
                        close: () {
                          context.read<ResourceCubit>().getUserResources();
                          searchController.clear();
                        }),

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
                                SearchResultButton(function: () {
                                          context
                                              .read<ResourceCubit>()
                                              .getUserResources();
                                          searchController.clear();
                                        },),
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
                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 0.78),
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.resources.length,
                                          itemBuilder: (context, index) {
                                            return Semantics(
                                              button: true,
                                              child: InkWell(
                                                onTap: () {
                                                  _showBottomSheet(
                                                    context,
                                                    id: state
                                                        .resources[index].id!,
                                                  );
                                                },
                                                child: GroupContainer(
                                                  height: height,
                                                  width: width,
                                                  image: state.resources[index]
                                                          .imageUrl ??
                                                      "",
                                                  title: state.resources[index]
                                                          .title ??
                                                      "",
                                                  link: state
                                                      .resources[index].link!,
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
