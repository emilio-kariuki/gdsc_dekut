import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/utilities/Widgets/profile_card.dart';
import 'package:gdsc_bloc/utilities/Widgets/profile_padding.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../blocs/app_functionality/user/user_cubit.dart';
import '../../blocs/minimal_functonality/admin_checker/admin_cubit.dart';
import '../../data/services/providers/auth_providers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: LogoutButtonContainer(),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  context.read<UserCubit>().getUser();
                });
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserProfilePicture(height: height),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              "Account",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: const Color(0xff000000),
                              ),
                            ),
                          ),
                          AccountButtons(),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTitle(width: width, title: "Community"),
                          CommunityButtons(),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTitle(
                            width: width,
                            title: "Help",
                          ),
                          HelpButtons(),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTitle(width: width, title: "About"),
                          AboutButtons()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    });
  }
}

class LogoutButtonContainer extends StatelessWidget {
  const LogoutButtonContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            await AuthProviders().logoutAccount().then(
                  (value) => Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/login",
                    ModalRoute.withName('/login'),
                  ),
                );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: AutoSizeText(
            "Log Out",
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xffffffff),
            ),
          ),
        ),
      ),
    );
  }
}

class AboutButtons extends StatelessWidget {
  const AboutButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.about,
            title: "About app",
            function: () {
              Navigator.pushNamed(context, '/about_app');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.version,
            title: "Version - 2.2.0",
            function: () {},
            showTrailing: false,
          ),
          const ProfilePadding(),
        ],
      ),
    );
  }
}

class HelpButtons extends StatelessWidget {
  const HelpButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.feedbackz,
            title: "Send Feedback",
            function: () {
              Navigator.pushNamed(context, '/send_feedback');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.problemz,
            title: "Report problem",
            function: () {
              Navigator.pushNamed(context, '/report_problem');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.contact,
            title: "Contact Developer",
            function: () {
              Navigator.pushNamed(context, '/contact_developer');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
        ],
      ),
    );
  }
}

class CommunityButtons extends StatelessWidget {
  const CommunityButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.community_leads,
            title: "Community leads",
            function: () {
              Navigator.pushNamed(context, '/community_leads');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
          BlocProvider(
            create: (context) => AdminCubit()..checkUserStatus(),
            child: BlocConsumer<AdminCubit, AdminState>(
              listener: (context, state) {},
              builder: (context, state) {
                return ProfileCard(
                  leadingLogo: AppImages.admin,
                  title: "Admin",
                  function: () {
                    if (state is UserAdmin) {
                      return Navigator.pushNamed(context, '/admin_page');
                    } else {
                      return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          content: Center(
                            child: AutoSizeText(
                              "You are not an admin",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  showTrailing: true,
                );
              },
            ),
          ),
          const ProfilePadding(),
        ],
      ),
    );
  }
}

class AccountButtons extends StatelessWidget {
  const AccountButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.person_black,
            title: "Profile",
            function: () {
              Navigator.pushNamed(context, '/personal_information');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
          ProfileCard(
            leadingLogo: AppImages.resources_black,
            title: "Resources",
            function: () {
              Navigator.pushNamed(context, '/user_resources');
            },
            showTrailing: true,
          ),
          const ProfilePadding(),
        ],
      ),
    );
  }
}

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSuccess) {
          return Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              CachedNetworkImage(
                imageUrl:  state.user.imageUrl! == "imageUrl"
                        ? AppImages.defaultImage
                        : state.user.imageUrl!,
                imageBuilder: (context, imageProvider) => Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      width: 0.5,
                      color: Colors.grey[500]!,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              AutoSizeText(
                state.user.name!,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: const Color(0xff000000),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              AutoSizeText(
                state.user.email!,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xff666666),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class ProfileTitle extends StatelessWidget {
  const ProfileTitle({
    super.key,
    required this.width,
    required this.title,
  });

  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: const Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}
