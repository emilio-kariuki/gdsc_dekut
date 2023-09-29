// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_functionality/resource/resource_cubit.dart';
import '../../blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import '../../data/services/providers/app_providers.dart';

class AdminApprovedResourceCard extends StatelessWidget {
  AdminApprovedResourceCard({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.image,
    required this.editFunction,
    required this.link,
    required this.id,
    required this.approveFunction,
    required this.category,
  });

  final double height;
  final String image;

  final String title;
  final double width;
  final String link;
  final String category;

  final String id;
  final Function() editFunction;
  final Function() approveFunction;

  final imageController = TextEditingController();
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();

  void _showImageDialog(
      BuildContext context, String imageUrl, String title, String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Dialog(
            insetPadding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: height * 0.6,
                  ),
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Scaffold(
                    bottomNavigationBar: Container(
                        height: height * 0.11,
                        width: width,
                        decoration: BoxDecoration(
                          border: const Border(
                              top: BorderSide(
                                  width: 0.4, color: Color(0xff666666))),
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
                                                  .copyToClipboard(text: link);
                                            },
                                            icon: Icon(
                                                state is Copied
                                                    ? Icons.check
                                                    : Icons.link,
                                                size: 22,
                                                color: Colors.white),
                                          ),
                                        ),
                                        AutoSizeText(
                                          state is Copied ? "Copied" : "Copy",
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
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
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    // padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      onPressed: () {
                                        // Providers().openLink(link: link);
                                      },
                                      icon: const Icon(Icons.visibility,
                                          size: 22, color: Colors.white),
                                    ),
                                  ),
                                  AutoSizeText(
                                    "View",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
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
                                    icon: const Icon(Icons.edit,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                AutoSizeText(
                                  "Tweet",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
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
                                    icon: const Icon(Icons.share,
                                        size: 22, color: Colors.white),
                                  ),
                                ),
                                AutoSizeText(
                                  "Share",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        title: Text(
                          title,
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              ))
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
                                  arguments: ImageArguments(
                                      title: title, image: image));
                            },
                            child: CachedNetworkImage(
                              height: height * 0.27,
                              width: width,
                              placeholder: (context, url) {
                                return Container(
                                    height: height * 0.27,
                                    width: width,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 243, 243, 243),
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
                            body: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AutoSizeText(
                                    title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  AutoSizeText(
                                    category,
                                    overflow: TextOverflow.clip,
                                    maxLines: 3,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // AutoSizeText(
                                  //   about,
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: () {
          _showImageDialog(context, image, title, link);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 106, 81, 81),
              width: 0.2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      _showImageDialog(context, image, title, link);
                    },
                    child: CachedNetworkImage(
                      height: 50,
                      width: 50,
                      placeholder: (context, url) {
                        return Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243),
                              // border: Border.all(width: 0.4, color: Color(0xff666666)),
                              borderRadius: BorderRadius.circular(10)),
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
                      fit: BoxFit.fitHeight,
                      imageBuilder: (context, imageProvider) {
                        return AnimatedContainer(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 0.4, color: const Color(0xff666666)),
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
              ],
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(
                    title,
                    maxLines: 2,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 SizedBox(height: height * 0.01,),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 36,
                    width: width * 0.7,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: editFunction,
                            child: AutoSizeText(
                              "Reject",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xffffffff),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                            width: 110,
                            child: BlocConsumer<ResourceCubit, ResourceState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xFF217604),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: Colors.black,
                                        width: 0.1,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<ResourceCubit>(context)
                                        .approveResource(id: id);
                                  },
                                  child: AutoSizeText(
                                    "Approve",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
