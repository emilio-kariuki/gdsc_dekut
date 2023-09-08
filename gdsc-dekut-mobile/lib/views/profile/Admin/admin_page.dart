import 'package:flutter/material.dart';
import 'package:gdsc_bloc/utilities/image_urls.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  final List<Map<String, dynamic>> adminActivities = [
    {
      "title": "Events",
      "location": "/admin_event",
      "image": AppImages.event,
    },
    {
      "title": "Resources",
      "location": "/admin_resources",
      "image": AppImages.resources,
    },
    {
      "title": "Announcements",
      "location": "/admin_announcements",
      "image": AppImages.announcement,
    },
    {
      "title": "Twitter Spaces",
      "location": "/admin_twitter",
      "image": AppImages.twitter,
    },
    {
      "title": "Tech Groups",
      "location": "/admin_groups",
      "image": AppImages.groups,
    },
    {
      "title": "Leads",
      "location": "/admin_lead",
      "image": AppImages.leads,
    },
    {
      "title": "Developers",
      "location": "/admin_developers",
      "image": AppImages.developers,
    },
    {
      "title": "Feedback",
      "location": "/admin_feedback",
      "image": AppImages.feedback,
    },
    {
      "title": "Reports",
      "location": "/admin_reports",
      "image": AppImages.problem,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff666666), size: 20),
        title: Text(
          "Admin Page",
          style: GoogleFonts.inter(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: const Color(0xff666666),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              itemCount: adminActivities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.78,
              ),
              itemBuilder: (context, index) {
                return Semantics(
                  button: true,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.pushNamed(
                          context, adminActivities[index]["location"]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: height * 0.13,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF282828),
                              width: 0.15,
                            ),
                          ),
                          child: LottieBuilder.asset(
                            adminActivities[index]["image"],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          adminActivities[index]["title"],
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF1F1F1F),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
