import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Announcements/tabs/admin_announcement_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Announcements/tabs/post_admin_announcement.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../blocs/app_functionality/announcement/announcement_cubit.dart';



class AdminAnnouncements extends StatefulWidget {
  const AdminAnnouncements({super.key});

  @override
  State<AdminAnnouncements> createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabController!.length,
      child: BlocProvider(
        create: (context) => AnnouncementCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: Color(0xff666666), size: 20),
                title: Text(
                  "Admin Announcements",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Announcements",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Post Announcement",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                ])),
            body: TabBarView(controller: tabController, children: [
               AdminAnnouncementsTab(),
               AdminAnnouncementPostPage(
                tabController: tabController!,
              ),
            ]),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
