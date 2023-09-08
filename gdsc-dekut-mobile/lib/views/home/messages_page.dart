// // ignore_for_file: prefer_const_constructors, deprecated_member_use, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:gdsc_bloc/data/Models/message_model.dart';
// import 'package:gdsc_bloc/data/Services/Providers/providers.dart';
// import 'package:gdsc_bloc/data/Services/Repositories/repository.dart';
// import 'package:gdsc_bloc/utilities/Widgets/chat_bubble.dart';
// import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
// import 'package:gdsc_bloc/utilities/image_urls.dart';
// import 'package:gdsc_bloc/utilities/route_generator.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grouped_list/grouped_list.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';


// class MessagesPage extends StatefulWidget {
//   const MessagesPage({super.key});

//   @override
//   State<MessagesPage> createState() => _MessagesPageState();
// }

// class _MessagesPageState extends State<MessagesPage> {
//   final messageController = TextEditingController();
//   final scrollController = ScrollController();
//   final focusNode = FocusNode();
//   String? image;
//   File? imageFile;
//   bool _visible = true;

//   @override
//   void initState() {
//     super.initState();
//     messageController.addListener(() {
//       setState(() {});
//     });
//     scrollController.addListener(() {
//       if (scrollController.position.atEdge) {
//         if (scrollController.position.pixels != 0) {
//           setState(() {
//             _visible = false;
//           });
//         }
//       } else if (!_visible) {
//         setState(() {
//           _visible = true;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).viewInsets.bottom;
//     final width = MediaQuery.of(context).size.width;
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(AppImages.background),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: BlocProvider(
//         create: (context) => AppFunctionsCubit(),
//         child: Builder(builder: (context) {
//           return Scaffold(
//             backgroundColor: Colors.transparent,
//             floatingActionButton: _visible
//                 ? SizedBox(
//                     height: 40,
//                     width: 40,
//                     child: FloatingActionButton(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100),
//                       ),
//                       onPressed: () {
//                         scrollController.animateTo(
//                           scrollController.position.maxScrollExtent,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeOut,
//                         );
//                       },
//                       backgroundColor: Color(0xFF16483E),
//                       child: Icon(
//                         Icons.arrow_circle_down,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   )
//                 : SizedBox.shrink(),
//             appBar: AppBar(
//               elevation: 0,
//               backgroundColor: Color(0xFF16483E),
//               leading: CachedNetworkImage(
//                 height: height * 0.12,
//                 width: width * 0.33,
//                 placeholder: (context, url) {
//                   return Container(
//                     height: height * 0.12,
//                     width: width * 0.33,
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 243, 243, 243),
//                         borderRadius: BorderRadius.circular(10)),
//                   );
//                 },
//                 errorWidget: ((context, url, error) {
//                   return const Icon(
//                     Icons.error,
//                     size: 20,
//                     color: Colors.red,
//                   );
//                 }),
//                 imageUrl: AppImages.eventImage,
//                 fit: BoxFit.fitHeight,
//                 imageBuilder: (context, imageProvider) {
//                   return AnimatedContainer(
//                     margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                           width: 0.4, color: const Color(0xFFFFFFFF)),
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     duration: const Duration(milliseconds: 500),
//                   );
//                 },
//               ),
//               title: Text(
//                 "Community Page",
//                 style: GoogleFonts.inter(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             bottomNavigationBar: Container(
//               color: Colors.transparent,
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(bottom: 3, left: 10, top: 3, right: 10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           BlocBuilder<AppFunctionsCubit, AppFunctionsState>(
//                             builder: (context, state) {
//                               if (state is ImageUploading) {
//                                 return Center(child: LoadingCircle());
//                               } else if (state is ImagePicked) {
//                                 return state.image == "null"
//                                     ? SizedBox.shrink()
//                                     : Container(
//                                         height: 150,
//                                         width: 600,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                           border: Border.all(
//                                               width: 0.4,
//                                               color: const Color(0xff666666)),
//                                           image: DecorationImage(
//                                             image: FileImage(state.image),
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),
//                                       );
//                               } else {
//                                 return SizedBox.shrink();
//                               }
//                             },
//                           ),
//                           TextFormField(
//                             onTap: () {
//                               scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 100),
//                                   curve: Curves.easeIn,
//                                 );
//                             },
//                             onTapOutside: (event) {
//                               if (event.runtimeType == TapUpDetails) {
//                                 focusNode.unfocus();
//                               }else{
//                                 scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 100),
//                                   curve: Curves.easeIn,
//                                 );
//                               }

//                             },
                            
//                             controller: messageController,
//                             focusNode: focusNode,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 15,
//                             minLines: 1,
//                             style: GoogleFonts.inter(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: const Color(0xffFFFFFF),
//                             ),
//                             decoration: InputDecoration(
//                               fillColor: Colors.blueGrey[900]!,
//                               contentPadding: EdgeInsets.all(15),
//                               filled: true,
//                               suffixIcon: BlocConsumer<AppFunctionsCubit,
//                                   AppFunctionsState>(
//                                 listener: (context, state) {
//                                   if (state is ImagePicked) {
//                                     image = state.imageUrl;
//                                     imageFile = state.image;
//                                   }
//                                 },
//                                 builder: (context, state) {
//                                   return IconButton(
//                                       onPressed: () {
//                                         BlocProvider.of<AppFunctionsCubit>(
//                                                 context)
//                                             .getImage();
//                                       },
//                                       icon: Icon(
//                                         Icons.attach_file,
//                                         color: Colors.white,
//                                         size: 18,
//                                       ));
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                                 borderSide: BorderSide(
//                                     color: Colors.grey[500]!, width: 0.4),
//                               ),
//                               hintStyle: GoogleFonts.inter(
//                                 fontSize: 14,
//                                 color: Colors.grey[400],
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Color(0xff204F46),
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: IconButton(
//                         onPressed: () async {
//                           if (image != null ||
//                               messageController.text.isNotEmpty) {
//                             Providers().sendMessage(
//                                 message: messageController.text,
//                                 image: image ?? "null");
//                             messageController.clear();
                            
//                             context
//                                 .read<AppFunctionsCubit>()
//                                 .emit(ImagePickingFailed(message: "null"));
//                             image = null;
//                           }
//                           scrollController.animateTo(
//                                   scrollController.position.maxScrollExtent,
//                                   duration: const Duration(milliseconds: 100),
//                                   curve: Curves.easeIn,
//                                 );
//                         },
//                         icon: Icon(
//                           Icons.send,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             body: StreamBuilder<List<Message>>(
//               stream: Repository().getMessages(),
//               builder: (context, snapshot) {
//                 Widget out = const SizedBox.shrink();
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   out = Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (snapshot.hasData) {
//                   out = GroupedListView(
//                     controller: scrollController,
//                     elements: snapshot.data!,
//                     order: GroupedListOrder.ASC,
//                     groupBy: (element) {
//                       final timestamp = element.timestamp.toLocal();
//                       final now = DateTime.now();
//                       final startOfToday =
//                           DateTime(now.year, now.month, now.day);

//                       if (timestamp.isAfter(startOfToday)) {
//                         return 'Today';
//                       } else {
//                         final formatter = DateFormat('dd MMM yyyy');
//                         return formatter.format(timestamp);
//                       }
//                     },
//                     groupSeparatorBuilder: (String groupByValue) {
//                       // Build the group header widget
//                       return Center(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             top: 7,
//                             bottom: 7,
//                           ),
//                           child: Container(
//                             width: double.infinity,
//                             constraints: BoxConstraints(
//                               maxWidth: width * 0.3,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20)),
//                               color: Color(0xff204F46),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Center(
//                                 child: Text(
//                                   groupByValue,
//                                   style: GoogleFonts.inter(
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     itemBuilder: (context, dynamic element) {
//                       final event = element as Message;
//                       final timestamp = DateTime.fromMicrosecondsSinceEpoch(
//                           event.timestamp.microsecondsSinceEpoch);

//                       return InkWell(
//                         onLongPress: () {
//                           if (event.id ==
//                               FirebaseAuth.instance.currentUser!.uid) {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     backgroundColor: Color(0xffFFFFFF),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     title: Text(
//                                       "Do you want to Delete?",
//                                       style: GoogleFonts.inter(
//                                         fontSize: 15,
//                                         color: Color(0xff000000),
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     content: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Text(
//                                           "Are you sure you want to delete this message?",
//                                           style: GoogleFonts.inter(
//                                             fontSize: 14,
//                                             color: Color(0xff5B5561),
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Row(
//                                           children: [
//                                             GestureDetector(
//                                               onTap: () async {
//                                                 Providers().deleteMessage(
//                                                     time: event.time);
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 height: 50,
//                                                 width: width * 0.3,
//                                                 margin:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 5),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.black,
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Delete",
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 14,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Spacer(),
//                                             GestureDetector(
//                                               onTap: () async {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 height: 50,
//                                                 width: width * 0.3,
//                                                 margin:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 5),
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                 ),
//                                                 child: Center(
//                                                   child: Text(
//                                                     "Cancel",
//                                                     style: GoogleFonts.inter(
//                                                       fontSize: 14,
//                                                       color: Colors.black,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 });
//                           }
//                         },
//                         child: BubbleSpecialOne(
//                           // sent: true,
//                           // delivered: true,
//                           // seen: true,
//                           text: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               event.id == FirebaseAuth.instance.currentUser!.uid
//                                   ? Container()
//                                   : Text(
//                                       event.name,
//                                       style: GoogleFonts.roboto(
//                                         fontSize: 13,
//                                         color: Colors.red[400],
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                               const SizedBox(
//                                 height: 2,
//                               ),
//                               event.image == "null"
//                                   ? SizedBox.shrink()
//                                   : Column(
//                                       children: [
//                                         const SizedBox(
//                                           height: 8,
//                                         ),
//                                         Semantics(
//                                           button: true,
//                                           child: InkWell(
//                                             onTap: () {
//                                               focusNode.unfocus();
//                                               Navigator.pushNamed(
//                                                   context, '/image_view',
//                                                   arguments: ImageArguments(
//                                                       title: "Image view",
//                                                       image: event.image));
//                                             },
//                                             child: CachedNetworkImage(
//                                               height: MediaQuery.of(context)
//                                                       .size
//                                                       .height *
//                                                   .2,
//                                               placeholder: (context, url) {
//                                                 return Container(
//                                                   height: MediaQuery.of(context)
//                                                           .size
//                                                           .height *
//                                                       .2,
//                                                   decoration: BoxDecoration(
//                                                       color:
//                                                           const Color.fromARGB(
//                                                               255,
//                                                               243,
//                                                               243,
//                                                               243),
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               3)),
//                                                 );
//                                               },
//                                               errorWidget:
//                                                   ((context, url, error) {
//                                                 return const Icon(
//                                                   Icons.error,
//                                                   size: 20,
//                                                   color: Colors.red,
//                                                 );
//                                               }),
//                                               imageUrl: event.image,
//                                               fit: BoxFit.fitHeight,
//                                               imageBuilder:
//                                                   (context, imageProvider) {
//                                                 return AnimatedContainer(
//                                                   decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     border: Border.all(
//                                                         width: 0.4,
//                                                         color: const Color(
//                                                             0xff666666)),
//                                                     image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                   duration: const Duration(
//                                                       milliseconds: 500),
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 8,
//                                         ),
//                                       ],
//                                     ),
//                               const SizedBox(
//                                 height: 2,
//                               ),
//                               Linkify(
//                                   onOpen: (link) async {
//                                     if (await canLaunch(link.url)) {
//                                       await launch(link.url);
//                                     } else {
//                                       throw 'Could not launch $link';
//                                     }
//                                   },
//                                   text: event.message,
//                                   linkifiers: const [
//                                     UrlLinkifier(),
//                                     EmailLinkifier(),
//                                   ],
//                                   style: GoogleFonts.inter(
//                                     fontSize: 11,
//                                     color: event.id ==
//                                             FirebaseAuth
//                                                 .instance.currentUser!.uid
//                                         ? Colors.white
//                                         : Colors.black,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.3,
//                                     // letterSpacing: 0.4
//                                   ),
//                                   linkStyle: GoogleFonts.inter(
//                                     fontSize: 11,
//                                     color: Colors.blue[300],
//                                     fontWeight: FontWeight.w400,
//                                     // letterSpacing: 0.4
//                                   )),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "${timestamp.hour}:${timestamp.minute} ${timestamp.hour >= 12 ? "PM" : "AM"}",

//                                     style: GoogleFonts.quicksand(
//                                       fontSize: 10,
//                                       color: event.id ==
//                                               FirebaseAuth
//                                                   .instance.currentUser!.uid
//                                           ? Color.fromARGB(255, 208, 207, 207)
//                                           : Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           isSender:
//                               event.id == FirebaseAuth.instance.currentUser!.uid
//                                   ? true
//                                   : false,
//                           color:
//                               event.id == FirebaseAuth.instance.currentUser!.uid
//                                   ? Color(0xff204F46)
//                                   : Colors.white,
//                           textStyle: GoogleFonts.inter(
//                             fontSize: 14,
//                             color: Colors.white,
//                             fontStyle: FontStyle.italic,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//                 return out;
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
