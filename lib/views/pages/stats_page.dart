import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gympanion/views/data/constants.dart';
import 'package:gympanion/views/data/user_stats.dart';
import 'package:gympanion/views/pages/activity_browser_page.dart';
import 'package:gympanion/views/pages/pr_page.dart';
import 'package:gympanion/views/pages/sleep_page.dart';
import 'package:gympanion/views/widgets/custom_card_element.dart';
import 'package:provider/provider.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('stats builddddddddddddddd');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'Summary',
              style: AppTextStyles.displayMedium,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.custom(
              gridDelegate: SliverStairedGridDelegate(
                crossAxisSpacing: 24,
                mainAxisSpacing: 12,
                pattern: [
                  StairedGridTile(0.5, 1),
                  StairedGridTile(0.5, .85),
                  StairedGridTile(1.0, 10 / 4),
                ],
              ),
              childrenDelegate: SliverChildListDelegate([
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivityBrowserPage(
                        activityType: ActivityType.workout,
                      ),
                    ));
                  },
                  child: CustomCardElement(
                    backgroundImagePath: 'assets/images/workout.png',
                    color: Color(0xFF2B2F4A),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.black.withAlpha(180),
                        child: Center(
                          child: Text(
                            '${Provider.of<UserStats>(context).previousWorkoutsCount} Workouts',
                            style: AppTextStyles.titleLarge
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActivityBrowserPage(
                        activityType: ActivityType.cardio,
                      ),
                    ));
                  },
                  child: CustomCardElement(
                    backgroundImagePath: 'assets/images/cardio.png',
                    color: Color(0xFF2E4A7D),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.black.withAlpha(180),
                        child: Center(
                          child: Text(
                            '${Provider.of<UserStats>(context).previousCardiosCount} Cardio',
                            style: AppTextStyles.titleLarge
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PRPage(),
                    ));
                  },
                  child: CustomCardElement(
                    backgroundImagePath: 'assets/images/pr.png',
                    color: Color(0xFF6A3D2F),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.black.withAlpha(180),
                        child: Center(
                          child: Text(
                            'PRs',
                            style: AppTextStyles.titleLarge
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CustomCardElement(
                  backgroundImagePath: 'assets/images/body.png',
                  color: Color(0xFF2F5D50),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.black.withAlpha(180),
                      child: Center(
                        child: Text(
                          'Body',
                          style: AppTextStyles.titleLarge
                              .copyWith(color: Colors.white70),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SleepPage(),
                    ));
                  },
                  child: CustomCardElement(
                    backgroundImagePath: 'assets/images/sleep.png',
                    color: Color(0xFF3E3B72),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.black.withAlpha(180),
                        child: Center(
                          child: Text(
                            'Sleep',
                            style: AppTextStyles.titleLarge
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
