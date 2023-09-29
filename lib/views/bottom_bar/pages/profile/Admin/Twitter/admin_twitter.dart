import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../blocs/app_functionality/twitter_space/twitter_space_cubit.dart';
import 'tabs/post_resource_admin_page.dart';
import 'tabs/twitter_spaces_tab.dart';

class AdminTwitter extends StatefulWidget {
  const AdminTwitter({super.key});

  @override
  State<AdminTwitter> createState() => _AdminTwitterState();
}

class _AdminTwitterState extends State<AdminTwitter>
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
        create: (context) => TwitterSpaceCubit(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: Color(0xff666666), size: 20),
                title: Text(
                  "Admin Twitter",
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff666666),
                  ),
                ),
                bottom: TabBar(controller: tabController, tabs: [
                  Tab(
                    child: Text(
                      "Twitter Spaces",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Post Space",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff666666),
                      ),
                    ),
                  ),
                ])),
            body: TabBarView(controller: tabController, children: [
              AppSpaces(
                tabController: tabController!,
              ),
              PostAdminSpace(
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
