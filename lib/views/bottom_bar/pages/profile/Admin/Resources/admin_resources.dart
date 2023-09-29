import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Resources/tabs/post_admin_resource_page.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Resources/tabs/app_resources.dart';
import 'package:gdsc_bloc/views/bottom_bar/pages/profile/Admin/Resources/tabs/approve_resource_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../blocs/app_functionality/resource/resource_cubit.dart';

class AdminResources extends StatefulWidget {
  const AdminResources({super.key});

  @override
  State<AdminResources> createState() => _AdminResourcesState();
}

class _AdminResourcesState extends State<AdminResources>
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
        create: (context) => ResourceCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: Color(0xff666666), size: 20),
                title: Text(
                  "Admin Resources",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Resources",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Approve",
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
              AppResources(
                tabController: tabController!,
              ),
              ApprovedResources(
                tabController: tabController!,
              ),
              AdminResourcePostPage(
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
