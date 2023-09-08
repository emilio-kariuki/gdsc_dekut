import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:gdsc_bloc/views/home/home_page.dart';
import 'package:gdsc_bloc/views/home/profile_page.dart';
import 'package:gdsc_bloc/views/home/resources_page.dart';
import 'package:gdsc_bloc/views/pages/events_page.dart';

import '../blocs/minimal_functonality/bottom_navigation/bottom_navigation_cubit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget getBody() {
    List<Widget> pages = [
      EventPage(),
      ResourcesPage(),
      EventsPage(),
      const ProfilePage(),
    ];
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return IndexedStack(
          index: state is TabChanged ? state.index : 0,
          children: pages,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationCubit(),
      child: Scaffold(
          // backgroundColor: const Color(0xffF6F6F6),
          extendBody: false,
          body: getBody(),
          bottomNavigationBar: getFooter()),
    );
  }

  Widget getFooter() {
    final List<Map<String, dynamic>> items = [
      {
        "two": Icons.home_outlined,
        "one": Icons.home_rounded,
        "three": "Home",
      },
      {
        "two": Icons.window_outlined,
        "one": Icons.window_rounded,
        "three": "Resources",
      },
      {
        "two": Icons.filter_frames_outlined,
        "one": Icons.filter_frames_rounded,
        "three": "Events",
      },
      {
        "two": Icons.person_2_outlined,
        "one": Icons.person_2_rounded,
        "three": "Profile",
      },
    ];
    return Builder(builder: (context) {
      return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        builder: (context, state) {
          return AnimatedBottomNavigationBar.builder(
            elevation: 0,
            // backgroundColor: Colors.white,
            notchSmoothness: NotchSmoothness.softEdge,
            splashRadius: 2,
            itemCount: items.length,
            activeIndex: state is TabChanged ? state.index : 0,
            gapWidth: 10,
            onTap: (index) {
              BlocProvider.of<BottomNavigationCubit>(context).changeTab(index);
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            tabBuilder: (int index, bool isActive) {
              final icons = items[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Icon(
                    isActive ? icons['one'] : icons['two'],
                    size: 22,
                    color: isActive ? Colors.deepOrange : Color(0xff666666),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    icons['three'],
                    style: TextStyle(
                      color:
                          isActive ? Colors.deepOrange : Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              );
            },
          );
        },
      );
    });
  }
}
