import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/Widgets/not_found/no_resource_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

class ResourceCategory extends StatelessWidget {
  const ResourceCategory({
    super.key,
    required this.height,
    required this.width,
    required this.category,
    required this.image,
  });

  final double height;
  final double width;
  final String category;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResourceCubit()..getResourcesByCategory(category: category),
      child: Builder(builder: (context) {
        return BlocBuilder<ResourceCubit, ResourceState>(
          builder: (context, state) {
            if (state is ResourceLoading) {
              return const Center(child: LoadingCircle());
            } else if (state is ResourceSuccess) {
              return SizedBox(
                height: height * 0.18,
                child: state.resources.isEmpty
                    ? Center(
                        child: NoResourceCard(
                          height: height,
                          width: width,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: state.resources.length > 1 ||
                                state.resources.length < 3
                            ? state.resources.length
                            : 4,
                        itemBuilder: (context, index) {
                          final data = state.resources[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: index == 3
                                ? Semantics(
                                    button: true,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/more_resource',
                                            arguments: ResourceArguments(
                                                title: data.title!,
                                                category: category));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Show more",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.inter(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 17,
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : ResourceCard(
                                    resource: data,
                                  ),
                          );
                        }),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      }),
    );
  }
}

