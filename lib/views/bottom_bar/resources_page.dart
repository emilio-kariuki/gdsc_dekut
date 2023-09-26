import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/resource/resource_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/resource_category.dart';
import 'package:gdsc_bloc/utilities/Widgets/resource_title_widget.dart';
import 'package:gdsc_bloc/utilities/Widgets/resources_card.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/resource_model.dart';

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
              backgroundColor: const Color(0xff000000),
              elevation: 2,
              onPressed: () {
                Navigator.pushNamed(context, '/post_resource');
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.white,
              ),
              child: SafeArea(
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
                            color: const Color(0xff000000),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ResearchSearchContainer(searchController: searchController),
                        const SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<ResourceCubit, ResourceState>(
                          builder: (context, state) {
                            if (state is ResourceSuccess) {
                              return SearchResultView(
                                searchController: searchController,
                                width: width,
                                height: height,
                                resources: state.resources,
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
            ),
          );
        },
      ),
    );
  }
}

class ResearchSearchContainer extends StatelessWidget {
  const ResearchSearchContainer({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49,
      padding: const EdgeInsets.only(left: 15, right: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: Colors.grey[500]!,
            width: 0.8,
          )),
      child: TextFormField(
        controller: searchController,
        onFieldSubmitted: (value) {
          context
              .read<ResourceCubit>()
              .searchResource(query: value);
        },
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: const Color(0xff000000),
        ),
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
    );
  }
}

class SearchResultView extends StatelessWidget {
  const SearchResultView({
    super.key,
    required this.searchController,
    required this.width,
    required this.height,
    required this.resources,
  });

  final TextEditingController searchController;
  final double width;
  final double height;
  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
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
                  context.read<ResourceCubit>().getAllResources();
                  searchController.clear();
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.black,
                ))
          ],
        ),
        resources.isEmpty
            ? Center(
                child: AutoSizeText(
                  "No resources found",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xff666666),
                  ),
                ),
              )
            : GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  return ResourceCard(
                    link: resources[index].link!,
                    category: resources[index].category!,
                    // description: resources[index].description!,
                    width: width,
                    height: height,
                    image: resources[index].imageUrl!,
                    title: resources[index].title!,
                  );
                },
              ),
      ],
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
