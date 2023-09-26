import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/views/profile/Admin/Event/past_event.dart';
import 'package:gdsc_bloc/views/profile/Admin/Event/post_event_page.dart';
import 'package:gdsc_bloc/views/profile/Admin/Event/upcoming_events.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../blocs/app_functionality/event/event_cubit.dart';


class AdminEvent extends StatefulWidget {
  const AdminEvent({super.key});

  @override
  State<AdminEvent> createState() => _AdminEventState();
}

class _AdminEventState extends State<AdminEvent>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController? tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabController!.length,
      child: BlocProvider(
        create: (context) => EventCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme:
                    const IconThemeData(color: Color(0xff666666), size: 20),
                title: Text(
                  "Admin Event",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Upcoming",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Past",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Post",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                ])),
            body: TabBarView(controller: tabController, children: [
              UpComingEvents(
                tabController: tabController!,
              ),
              PastEvents(
                tabController: tabController!,
              ),
              PostEvent( tabController: tabController!,),
            ]),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
