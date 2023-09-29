import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';

import '../../blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import '../../data/models/resource_model.dart';
import '../../data/services/providers/app_providers.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    super.key,
    required this.resource,
    required this.isAdmin,
    required this.isApproved,
  });

  final Resource resource;
  final bool isAdmin;
  final bool isApproved;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * 0.34,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              _showImageDialog(
                  context, resource.imageUrl!, resource.title!, link);
            },
            child: CachedNetworkImage(
              height: height * 0.115,
              width: width * 0.32,
              placeholder: (context, url) {
                return Container(
                  height: height * 0.115,
                  width: width * 0.32,
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                );
              },
              errorWidget: ((context, url, error) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 0.4, color: const Color(0xff666666)),
                  ),
                  duration: const Duration(milliseconds: 500),
                  child: const Icon(
                    Icons.error,
                    size: 20,
                    color: Colors.red,
                  ),
                );
              }),
              imageUrl: image,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return AnimatedContainer(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 0.4, color: const Color(0xff666666)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  duration: const Duration(milliseconds: 500),
                );
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.28,
                    child: Text(title,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                )),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _showImageDialog(
    {required BuildContext context, required Resource resource}) {
  final height = MediaQuery.sizeOf(context).height;
  final width = MediaQuery.sizeOf(context).width;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Dialog(
          insetPadding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
                height: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: height * 0.6,
                ),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  bottomNavigationBar: Container(
                      height: height * 0.11,
                      width: width,
                      decoration: BoxDecoration(
                        border: const Border(
                            top: BorderSide(
                                width: 0.4, color: Color(0xff666666))),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlocProvider(
                            create: (context) => ClipboardCubit(),
                            child: Builder(builder: (context) {
                              return BlocBuilder<ClipboardCubit,
                                  ClipboardState>(
                                builder: (context, state) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[800],
                                            shape: BoxShape.circle),
                                        child: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<ClipboardCubit>(
                                                    context)
                                                .copyToClipboard(text: resource.link!);
                                          },
                                          icon: Icon(
                                              state is Copied
                                                  ? Icons.check
                                                  : Icons.link,
                                              size: 22,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Text(state is Copied ? "Copied" : "Copy",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                              ))
                                    ],
                                  );
                                },
                              );
                            }),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Tooltip(
                            message: "Add event to calendar",
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      AppProviders().openLink(link: link);
                                    },
                                    icon: Icon(Icons.visibility,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                Text("View",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                // padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {
                                    AppProviders().tweet(
                                        message:
                                            "Hello Devs👋 Iam happy to inform you about this cool resources and am sure it can help you guys🥳 here is the link $link");
                                  },
                                  icon: Icon(Icons.edit,
                                      size: 22, color: Colors.white),
                                ),
                              ),
                              Text("Tweet",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ))
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                // padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {
                                    AppProviders().share(
                                        message:
                                            "The link to join $title is $link");
                                  },
                                  icon: Icon(Icons.share,
                                      size: 22, color: Colors.white),
                                ),
                              ),
                              Text("Share",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ))
                            ],
                          )
                        ],
                      )),
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(40),
                    child: AppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      title: Text(title,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close,
                                size: 20, color: Colors.white))
                      ],
                    ),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Semantics(
                        button: true,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/image_view',
                                arguments:
                                    ImageArguments(title: title, image: image));
                          },
                          child: CachedNetworkImage(
                            height: height * 0.27,
                            width: width,
                            placeholder: (context, url) {
                              return Container(
                                  height: height * 0.27,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).iconTheme.color,
                                  )
                                  // border: Border.all(width: 0.4, color: Color(0xff666666)),

                                  );
                            },
                            errorWidget: ((context, url, error) {
                              return const Icon(
                                Icons.error,
                                size: 20,
                                color: Colors.red,
                              );
                            }),
                            imageUrl: image,
                            fit: BoxFit.cover,
                            imageBuilder: (context, imageProvider) {
                              return AnimatedContainer(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.4,
                                      color: const Color(0xff666666)),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Scaffold(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          body: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        )),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(category,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        )),
                                // const SizedBox(
                                //   height: 8,
                                // ),
                                // Text(
                                //   description,
                                //   overflow: TextOverflow.clip,
                                //   maxLines: 3,
                                //   style: GoogleFonts.inter(
                                //     fontSize: 12,
                                //     fontWeight: FontWeight.w500,
                                //
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
    },
  );
}
