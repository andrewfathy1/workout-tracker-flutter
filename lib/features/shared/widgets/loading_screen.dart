import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/features/stats/providers/user_stats.dart';
import 'package:gympanion/features/shared/widgets/app_navigator.dart';
import 'package:gympanion/features/auth/registeration_page.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => StreamBuilder<User?>(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        Provider.of<UserStats>(context, listen: false)
                            .reloadUserStats();
                        return AppNavigator();
                      }
                      return RegisterationPage();
                    },
                  )),
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: CircularProgressIndicator()),
    ]);
  }
}
