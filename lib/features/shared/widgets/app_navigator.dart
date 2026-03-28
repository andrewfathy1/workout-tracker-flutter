import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/core/services/firebase_auth_services.dart';
import 'package:gympanion/core/app/app_data.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/features/stats/providers/user_stats.dart';
import 'package:gympanion/features/shared/widgets/app_nav_bar.dart';
import 'package:gympanion/features/shared/widgets/background_widget.dart';
import 'package:provider/provider.dart';

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<UserStats>(context, listen: false).reloadUserStats();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    bool isMorning = timeNow.hour >= 0 && timeNow.hour < 12;
    bool isAfternoon = timeNow.hour >= 12 && timeNow.hour < 16;

    final isDarkMode = context.select<AppData, bool>((app) => app.isDarkMode);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          forceMaterialTransparency: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Text(
                  isMorning
                      ? 'Good Morning, ${snapshot.data?.displayName ?? ''}'
                      : isAfternoon
                          ? 'Good Afternoon, ${snapshot.data?.displayName ?? ''}'
                          : 'Good Evening, ${snapshot.data?.displayName ?? ''}',
                  style: AppTextStyles.titleLarge,
                );
              } else {
                return Text('Error');
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<AppData>(context, listen: false).toggleDarkMode();
              },
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
            IconButton(
              onPressed: () {
                Provider.of<AppData>(context, listen: false).resetAppData();
                Provider.of<FirebaseAuthServices>(context, listen: false)
                    .userSignout();
              },
              icon: Icon(Icons.logout),
            ),
          ]),
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(child: AppNavBar()),
        ],
      ),
    );
  }
}
