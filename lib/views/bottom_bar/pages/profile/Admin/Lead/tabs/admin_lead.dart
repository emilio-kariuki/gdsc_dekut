import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Lead/app_leads.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Lead/tabs/post_admin_lead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../blocs/app_functionality/leads/leads_cubit.dart';

class AdminLead extends StatefulWidget {
  const AdminLead({super.key});

  @override
  State<AdminLead> createState() => _AdminLeadState();
}

class _AdminLeadState extends State<AdminLead>
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
        create: (context) => LeadsCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: Color(0xff666666), size: 20),
                title: Text(
                  "Admin Leads",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Tech Leads",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Post Leads",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                ])),
            body: TabBarView(controller: tabController, children: [
              AppLeads(
                tabController: tabController!,
              ),
              PostAdminLead(
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
