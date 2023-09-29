import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/Widgets/image_view.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:gdsc_bloc/views/authentication/forgot_password_page.dart';
import 'package:gdsc_bloc/views/authentication/login_page.dart';
import 'package:gdsc_bloc/views/authentication/register_page.dart';
import 'package:gdsc_bloc/views/authentication/reset_password_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/profile_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/home/pages/annoucement_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/events/events_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/resources/resource_post_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/home/pages/tech_groups_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/home/pages/twitter_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/announcements/admin_announcements.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/event/admin_event.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Feedback/admin_feedback.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Groups/admin_groups.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Lead/tabs/admin_lead.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Reports/admin_reports.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/resources/admin_resources.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/admin_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/resources/more_resources_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../views/bottom_bar/pages/profile/Admin/twitter/admin_twitter.dart';
import '../views/bottom_bar/pages/profile/pages/about_page.dart';
import '../views/bottom_bar/pages/profile/pages/community_leads_page.dart';
import '../views/bottom_bar/pages/profile/pages/contact_developer_page.dart';
import '../views/bottom_bar/pages/profile/pages/personal_information_page.dart';
import '../views/bottom_bar/pages/profile/pages/report_problem_page.dart';
import '../views/bottom_bar/pages/profile/pages/send_feedback_page.dart';
import '../views/bottom_bar/pages/profile/pages/user_resources.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final resourceArgs = settings.arguments;

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/reset_password':
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case '/events_page':
        return MaterialPageRoute(builder: (_) => EventsPage());
      case '/twitter_page':
        return MaterialPageRoute(builder: (_) => TwitterPage());
      case '/tech_groups_page':
        return MaterialPageRoute(builder: (_) => TechGroupsPage());
      case '/personal_information':
        return MaterialPageRoute(builder: (_) => PersonalInformation());
      case '/community_leads':
        return MaterialPageRoute(builder: (_) => const CommunityLeads());
      case '/user_resources':
        return MaterialPageRoute(builder: (_) => UserResources());
      case '/send_feedback':
        return MaterialPageRoute(builder: (_) => SendFeedbackPage());
      case '/report_problem':
        return MaterialPageRoute(builder: (_) => ReportProblemPage());
      case '/contact_developer':
        return MaterialPageRoute(builder: (_) => const ContactDeveloperPage());
      case '/about_app':
        return MaterialPageRoute(builder: (_) => const AboutPage());
      case '/announcement_page':
        return MaterialPageRoute(builder: (_) => AnnouncementPage());
      case '/post_resource':
        return MaterialPageRoute(builder: (_) => ResourcePostPage());
      case '/admin_page':
        return MaterialPageRoute(builder: (_) => AdminPage());
      case '/admin_event':
        return MaterialPageRoute(builder: (_) => const AdminEvent());
      case '/admin_resources':
        return MaterialPageRoute(builder: (_) => const AdminResources());
      case '/admin_announcements':
        return MaterialPageRoute(builder: (_) => const AdminAnnouncements());
      case '/admin_twitter':
        return MaterialPageRoute(builder: (_) => const AdminTwitter());
      case '/admin_groups':
        return MaterialPageRoute(builder: (_) => const AdminGroups());
      case '/admin_lead':
        return MaterialPageRoute(builder: (_) => const AdminLead());

      case '/admin_feedback':
        return MaterialPageRoute(builder: (_) => const AppFeedback());
      case '/admin_reports':
        return MaterialPageRoute(builder: (_) => const AppReports());
      case '/more_resource':
        if (resourceArgs is ResourceArguments) {
          return MaterialPageRoute(
            builder: (_) => MoreResourcesPage(
              title: resourceArgs.title,
              category: resourceArgs.category,
            ),
          );
        } else {
          return _errorRoute();
        }
      case '/image_view':
        if (resourceArgs is ImageArguments) {
          return MaterialPageRoute(
            builder: (_) => ImageView(
              title: resourceArgs.title,
              image: resourceArgs.image,
            ),
          );
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      final height = MediaQuery.of(context).size.height;
      return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
            elevation: 0,
           
            iconTheme: const IconThemeData(color: Colors.black54),
          ),
          body: SizedBox(
            height: height * 0.9,
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(AppImages.oops, height: height * 0.2),
                Text(
                  "Page not found",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: const Color(0xff666666),
                  ),
                ),
              ],
            )),
          ));
    });
  }
}

class ResourceArguments {
  final String title;
  final String category;

  ResourceArguments({required this.title, required this.category});
}

class ImageArguments {
  final String title;
  final String image;

  ImageArguments({required this.title, required this.image});
}
