// ignore_for_file: avoid_print, use_build_context_synchronously, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/blocs/app_functionality/user/user_cubit.dart';
import 'package:gdsc_bloc/blocs/minimal_functonality/get_image/get_image_cubit.dart';
import 'package:gdsc_bloc/utilities/Widgets/input_field.dart';
import 'package:gdsc_bloc/utilities/Widgets/loading_circle.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/utilities/shared_preference_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});

  final imagePicker = ImagePicker();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final githubController = TextEditingController();

  final twitterController = TextEditingController();

  final linkedinController = TextEditingController();

  final technologyController = TextEditingController();

  String image = AppImages.defaultImage;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => GetImageCubit(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
          title: Text(
            "Personal Information",
            style: GoogleFonts.inter(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: const Color(0xff666666),
            ),
          ),
          leading: Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                context.read<UserCubit>().getUser();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocListener<UserCubit, UserState>(
            bloc: context.read<UserCubit>()..getUser(),
            listener: (context, state) {
              if (state is UserSuccess) {
                nameController.text = state.user.name!;
                emailController.text = state.user.email!;
                phoneController.text = state.user.phone!;
                githubController.text = state.user.github!;
                twitterController.text = state.user.twitter!;
                linkedinController.text = state.user.linkedin!;
                technologyController.text = state.user.technology!;
                image = state.user.imageUrl!;
              }
              if (state is UserUpdated) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: const Text("updated information successfully")));
              }

              if (state is UserError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Text(state.message)));
              }
            },
            child: UpdateProfileContainer(
              nameController: nameController,
              emailController: emailController,
              phoneController: phoneController,
              githubController: githubController,
              linkedinController: linkedinController,
              twitterController: twitterController,
              technologyController: technologyController,
              image: image,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<UserCubit>().getUser();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: height * 0.13,
                            width: height * 0.13,
                            decoration: const BoxDecoration(
                              color: Color(0xffF6F6F6),
                              shape: BoxShape.circle,
                            ),
                            child: BlocBuilder<GetImageCubit, GetImageState>(
                              builder: (context, state) {
                                if (state is ImagePicked) {
                                  image = state.imageUrl;
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      state.image,
                                      fit: BoxFit.fitHeight,
                                      height: height * 0.13,
                                      width: height * 0.13,
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CachedNetworkImage(
                                    imageUrl: image,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        height: height * 0.13,
                                        width: height * 0.13,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF6F6F6),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey[500]!,
                                            width: 0.7,
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ));
                                }
                                return const Center(
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                          FloatingImageContainer()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InputField(
                      controller: nameController,
                      hintText: "Enter your name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: emailController,
                      hintText: "Enter your email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: phoneController,
                      hintText: "Enter your phone",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your phone";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: githubController,
                      hintText: "Enter your github username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: twitterController,
                      hintText: "Enter your twitter username",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your twitter username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: technologyController,
                      hintText: "Enter your technology",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your technology";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputField(
                      controller: linkedinController,
                      hintText: "Enter your linkedin  name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your linkedin name";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UpdateProfileContainer extends StatelessWidget {
  const UpdateProfileContainer({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.githubController,
    required this.linkedinController,
    required this.twitterController,
    required this.technologyController,
    required this.image,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController githubController;
  final TextEditingController linkedinController;
  final TextEditingController twitterController;
  final TextEditingController technologyController;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state is UserLoading
            ? const LoadingCircle()
            : SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final userId = await SharedPreferencesManager().getId();
                    context.read<UserCubit>().updateUser(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          github: githubController.text,
                          linkedin: linkedinController.text,
                          twitter: twitterController.text,
                          userId: userId,
                          technology: technologyController.text,
                          image: image,
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff000000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Save Data",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class FloatingImageContainer extends StatelessWidget {
  const FloatingImageContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Align(
      alignment: Alignment.bottomRight,
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            context.read<GetImageCubit>().getImage();
          },
          child: Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.photo_camera_outlined,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
