import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/resource_category.dart';
import 'package:gdsc_bloc/utilities/Widgets/resource_title_widget.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_container.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_not_found.dart';
import 'package:gdsc_bloc/utilities/Widgets/search_result_button.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';


class ResourcesPage extends StatelessWidget {
  ResourcesPage({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ResourceCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 2,
              onPressed: () {
                Navigator.pushNamed(context, '/post_resource');
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
                size: 20,
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      AutoSizeText(
                        "Your Resources",
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SearchContainer(
                        searchController: searchController,
                        onChanged: (value) {
                          context
                              .read<ResourceCubit>()
                              .searchResource(query: value);
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          context
                              .read<ResourceCubit>()
                              .searchResource(query: value);
                          return null;
                        },
                        hint: "Search resource eg. flutter",
                        close: () {
                          context.read<ResourceCubit>().getAllResources();
                          searchController.clear();
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      BlocBuilder<ResourceCubit, ResourceState>(
                        builder: (context, state) {
                          if (state is ResourceSuccess) {
                            return Column(
                              children: [
                                SearchResultButton(
                                  function: () {
                                    context
                                        .read<ResourceCubit>()
                                        .getAllResources();
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
                                                crossAxisSpacing: 8),
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
                            return DefaultRecourceView(
                              height: height,
                              width: width,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DefaultRecourceView extends StatelessWidget {
  const DefaultRecourceView({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Mobile Development",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Mobile Development", category: "mobile"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "mobile",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ResourceWidget(
              title: "Data Science",
              location: '/more_resource',
              arguments:
                  ResourceArguments(title: "Data Science", category: "data"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "data",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Design Development",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Design Development", category: "design"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "design",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Web Development",
              location: '/more_resource',
              arguments:
                  ResourceArguments(title: "Web Development", category: "web"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "web",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Cloud Development",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Cloud Development", category: "cloud"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "cloud",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Internet of Things (IoT)",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Internet of Things (IoT)", category: "iot"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "iot",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Artificial Intelligence",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Artificial Intelligence", category: "ai"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "ai",
              image: AppImages.eventImage,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResourceWidget(
              title: "Game Development",
              location: '/more_resource',
              arguments: ResourceArguments(
                  title: "Game Development", category: "game"),
            ),
            ResourceCategory(
              height: height,
              width: width,
              category: "game",
              image: AppImages.eventImage,
            ),
          ],
        ),
      ],
    );
  }
}
