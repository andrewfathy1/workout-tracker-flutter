import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gympanion/views/data/app_data.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/notifiers.dart';
import 'package:gympanion/views/pages/current_page.dart';
import 'package:gympanion/views/pages/home_page.dart';
import 'package:gympanion/views/pages/profile_page.dart';
import 'package:gympanion/views/pages/start_page.dart';
import 'package:gympanion/views/pages/stats_page.dart';
import 'package:provider/provider.dart';

class AppNavBar extends StatelessWidget {
  AppNavBar({super.key});

  final List<Widget> pages = [
    HomePage(),
    StatsPage(),
    StartPage(),
    CurrentPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentNavIndex =
        context.select<AppData, int>((app) => app.currentNavBarIndex);
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: pages[currentNavIndex],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 32, left: 16, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.grey.shade500,
            ),
            child: ValueListenableBuilder(
                valueListenable: currentTrainingMode,
                builder: (context, currentTrainingMode, child) {
                  return GNav(
                    haptic: true,
                    selectedIndex: currentNavIndex,
                    color: Colors.black,
                    activeColor: Colors.black,
                    iconSize: 26,
                    tabBackgroundColor: Colors.amber.withAlpha(90),
                    padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16, vertical: 16),
                    gap: 8,
                    onTabChange: (value) =>
                        Provider.of<AppData>(context, listen: false)
                            .changeNavBarIndex(value),
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.workspaces_outlined,
                        text: 'Stats',
                      ),
                      GButton(
                        icon: Icons.add,
                        text: 'Start',
                      ),
                      GButton(
                        icon: Icons.timelapse,
                        iconActiveColor:
                            currentTrainingMode == TrainingMode.workout
                                ? AppColors.workoutColor
                                : currentTrainingMode == TrainingMode.cardio
                                    ? AppColors.cardioColor
                                    : Colors.black,
                        iconColor: currentTrainingMode == TrainingMode.workout
                            ? AppColors.workoutColor
                            : currentTrainingMode == TrainingMode.cardio
                                ? AppColors.cardioColor
                                : Colors.black,
                        text: 'Current',
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profile',
                      ),
                      // NavigationDestination(
                      //   icon: Icon(Icons.workspaces_outlined),
                      //   label: 'Stats',
                      // ),
                      // ValueListenableBuilder<TrainingMode>(
                      //     valueListenable: currentTrainingMode,
                      //     builder: (context, value, child) {
                      //       return NavigationDestination(
                      //         // icon:
                      //         // Lottie.asset('assets/animations/workout_loading.json'),
                      //         icon: AnimatedScale(
                      //           scale: value != TrainingMode.none ? 1.5 : 1,
                      //           duration: Duration(milliseconds: 700),
                      //           child: Icon(
                      //             Icons.timelapse,
                      //             color: value == TrainingMode.workout
                      //                 ? AppColors.workoutColor
                      //                 : value == TrainingMode.cardio
                      //                     ? AppColors.cardioColor
                      //                     : Colors.white,
                      //           ),
                      //         ),
                      //         label: 'Current',
                      //       );
                      //     }),
                      // NavigationDestination(
                      //   icon: Icon(Icons.person),
                      //   label: 'Profile',
                      // ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}
