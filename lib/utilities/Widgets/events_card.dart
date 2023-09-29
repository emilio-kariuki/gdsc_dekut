import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_bloc/data/models/event_model.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/pick_image_button.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/route_generator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../blocs/app_functionality/event/event_cubit.dart';
import '../../blocs/minimal_functonality/clipboard/clipboard_cubit.dart';
import '../../data/services/providers/app_providers.dart';
import 'pick_date_container.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key,
      required this.event,
      required this.isAdmin,
      required this.isPast});

  final EventModel event;
  final bool isAdmin;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = event;
    DateTime date = DateTime.parse(data.date!);

    int numberOfDays = date.difference(DateTime.now()).inDays.toInt();
    debugPrint("number of days $numberOfDays");
    String formattedDate = DateFormat.MMMEd().format(date);
    final duration = data.duration ?? 120;
    final time = date.add(Duration(minutes: duration));
    final startTime = DateFormat.jm().format(date);
    final endTime = DateFormat.jm().format(time);
    final String eventTime = "$startTime - $endTime";
    return BlocProvider(
      create: (context) => EventCubit(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ElevatedButton(
            onPressed: () {
              showEventSheet(
                context: context,
                event: event,
                time: eventTime,
                date: formattedDate,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0.15,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Semantics(
                          button: true,
                          child: InkWell(
                            onTap: () {
                              showEventSheet(
                                context: context,
                                event: event,
                                time: eventTime,
                                date: formattedDate,
                              );
                            },
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              placeholder: (context, url) {
                                return Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
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
                              imageUrl: event.imageUrl!,
                              fit: BoxFit.fitHeight,
                              imageBuilder: (context, imageProvider) {
                                return AnimatedContainer(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.4,
                                    ),
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
                          SizedBox(
                            height: height * 0.01,
                          ),
                          AutoSizeText(
                            event.title!,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          numberOfDays == 0 || numberOfDays == 1
                              ? Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: numberOfDays == 1
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    AutoSizeText(
                                      numberOfDays == 1
                                          ? "Tomorrow"
                                          : numberOfDays == 0
                                              ? "Today"
                                              : "",
                                      overflow: TextOverflow.clip,
                                      maxLines: 4,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: numberOfDays == 1
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            event.description!,
                            maxLines: 2,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          SizedBox(
                            height: 30,
                            width: width * 0.7,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.calendar,
                                          height: height * 0.02,
                                          width: width * 0.02,
                                          color:
                                              Theme.of(context).iconTheme.color,
                                        ),
                                        SizedBox(
                                          width: width * 0.01,
                                        ),
                                        AutoSizeText(formattedDate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!.copyWith(
                                              fontSize: 13
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppImages.clock,
                                      height: height * 0.02,
                                      width: width * 0.02,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    AutoSizeText(eventTime,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!.copyWith(
                                              fontSize: 13
                                            )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ],
                ), //
               !isAdmin ? SizedBox.shrink() :Visibility(
                  visible: isAdmin,
                  child: SizedBox(
                    height: 36,
                    child: Row(
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: 110,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 0.55,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              showEditEventDialog(
                                  context: context, event: event);
                            },
                            child: AutoSizeText(
                              "Edit",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: const Color(0xff5B5561),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 110,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
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
                              isPast
                                  ? BlocProvider.of<EventCubit>(context)
                                      .deleteEvent(
                                      id: event.id!,
                                    )
                                  : BlocProvider.of<EventCubit>(context)
                                      .completeEventById(
                                      id: event.id!,
                                    );
                            },
                            child: AutoSizeText(
                              isPast ? "Delete" : "Complete",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Visibility(
                          visible: isPast,
                          child: SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF217604),
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
                                BlocProvider.of<EventCubit>(context)
                                    .startEventById(
                                  id: event.id!,
                                );
                              },
                              child: Text(
                                "Start",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

void showEventSheet(
    {required BuildContext context,
    required EventModel event,
    required String time,
    required String date}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: height,
        constraints: BoxConstraints.loose(
          Size(
            width,
            height * 0.68,
          ),
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: Container(
              height: height * 0.11,
              width: width,
              decoration: BoxDecoration(
                border:  Border(
                    top: BorderSide(
                  width: 0.2,
                  color: Colors.grey[400]!
                )),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocProvider(
                    create: (context) => ClipboardCubit(),
                    child: Builder(builder: (context) {
                      return BlocBuilder<ClipboardCubit, ClipboardState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 78, 78, 78),
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<ClipboardCubit>(context)
                                        .copyToClipboard(text: event.link!);
                                  },
                                  icon: Icon(
                                      state is Copied
                                          ? Icons.check
                                          : Icons.link,
                                      size: 22,
                                      color: Colors.white),
                                ),
                              ),
                              AutoSizeText(state is Copied ? "Copied" : "Copy",
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
                          margin: const EdgeInsets.only(top: 10, bottom: 5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 78, 78, 78),
                          ),
                          child: IconButton(
                            onPressed: () {
                              AppProviders().openLink(link: event.link!);
                            },
                            icon: const Icon(Icons.app_registration_rounded,
                                size: 22, color: Colors.white),
                          ),
                        ),
                        AutoSizeText("Register",
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
                        margin: const EdgeInsets.only(top: 10, bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 78, 78, 78),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AppProviders().tweet(
                                message:
                                    "Hello Devs👋 Iam happy to inform you that i will be joining todays sessions here is the link ${event.link}");
                          },
                          icon: const Icon(Icons.edit,
                              size: 22, color: Colors.white),
                        ),
                      ),
                      AutoSizeText("Tweet",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        margin: const EdgeInsets.only(top: 10, bottom: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 78, 78, 78),
                        ),
                        child: IconButton(
                          onPressed: () {
                            AppProviders().share(
                                message:
                                    "${event.title} and the link is : ${event.link}");
                          },
                          icon: const Icon(Icons.share,
                              size: 22, color: Colors.white),
                        ),
                      ),
                      AutoSizeText("Share",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
              centerTitle: false,
              title: AutoSizeText(event.title!,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 14)),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close,
                        size: 20, color: Theme.of(context).iconTheme.color))
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
                            title: event.title!, image: event.imageUrl!));
                  },
                  child: CachedNetworkImage(
                    height: height * 0.27,
                    width: width,
                    placeholder: (context, url) {
                      return Container(
                          height: height * 0.27,
                          width: width,
                          decoration: const BoxDecoration());
                    },
                    errorWidget: ((context, url, error) {
                      return const Icon(
                        Icons.error,
                        size: 20,
                        color: Colors.red,
                      );
                    }),
                    imageUrl: event.imageUrl!,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return AnimatedContainer(
                        height: height * 0.27,
                        width: width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.4,
                          ),
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
              SizedBox(
                height: height * 0.011,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(event.title!,
                            overflow: TextOverflow.clip,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                )),
                        SizedBox(
                          height: height * 0.011,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.location,
                                    height: height * 0.013,
                                    width: width * 0.013,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  AutoSizeText(event.venue!,
                                      overflow: TextOverflow.clip,
                                      maxLines: 4,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          )),
                                ],
                              ),
                            ),
                            AutoSizeText(event.organizers!,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AutoSizeText(event.description!,
                            overflow: TextOverflow.clip,
                            maxLines: 4,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                )),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 45,
                      width: width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.calendar,
                                        height: height * 0.017,
                                        width: width * 0.017,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      AutoSizeText(date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              )),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.clock,
                                    height: height * 0.017,
                                    width: width * 0.017,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  AutoSizeText(time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

showEditEventDialog({
  required BuildContext context,
  required EventModel event,
}) {
  final height = MediaQuery.of(context).size.height;
  final nameController = TextEditingController(text: event.title);
  final descriptionController = TextEditingController(text: event.description);
  final venueController = TextEditingController(text: event.venue);
  final organizersController = TextEditingController(text: event.organizers);
  final linkController = TextEditingController(text: event.link);
  final dateController = TextEditingController(text: event.date);
  final imageController = TextEditingController(text: event.imageUrl);

  showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => EventCubit(),
          child: StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Dialog(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                insetPadding: const EdgeInsets.all(5),
                child: IntrinsicHeight(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            controller: nameController,
                            hintText: "Edit name of event",
                          ),
                     SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Description",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                            SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your description";
                              }
                              return null;
                            },
                            maxLines: 3,
                            textInputType: TextInputType.multiline,
                            controller: descriptionController,
                            hintText: "Edit description of event",
                          ),
                           SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Venue",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your venue";
                              }
                              return null;
                            },
                            controller: venueController,
                            hintText: "Edit venue of event",
                          ),
                           SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Organizers",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                     SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your organizers";
                              }
                              return null;
                            },
                            controller: organizersController,
                            hintText: "Edit organizers of event",
                          ),
                           SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Link",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                           SizedBox(
                            height: height * 0.01,
                          ),
                          InputField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your link";
                              }
                              return null;
                            },
                            controller: linkController,
                            hintText: "Edit link of event",
                          ),
                           SizedBox(
                            height: height * 0.02,
                          ),
                          PickDateContainer(
                            dateController: dateController,
                            title: "Pick Event Date",
                          ),
                     SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            "Attach a File",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          PickImageButton(
                            imageController: imageController,
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: BlocConsumer<EventCubit, EventState>(
                              bloc: BlocProvider.of<EventCubit>(context),
                              listener: (context, state) {
                                if (state is EventUpdated) {
                                  Navigator.pop(context);
                    
                                  debugPrint("called this update function");
                                }
                              },
                              builder: (context, state) {
                                return SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      BlocProvider.of<EventCubit>(context)
                                          .updateEvent(
                                              imageUrl: imageController.text,
                                              id: event.id!,
                                              title: nameController.text,
                                              description:
                                                  descriptionController.text,
                                              venue: venueController.text,
                                              organizers:
                                                  organizersController.text,
                                              link: linkController.text,
                                              date: dateController.text);
                                    },
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                        ),
                                    child: Text(
                                      "Update Event",
                                    ),
                                  ),
                                );
                              },
                            ),
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
      });
}
