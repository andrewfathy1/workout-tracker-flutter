import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/firebase_options.dart';
import 'package:gympanion/core/services/firebase_auth_services.dart';
import 'package:gympanion/core/app/app_data.dart';
import 'package:gympanion/features/cardio/providers/current_cardio_data.dart';
import 'package:gympanion/features/workouts/providers/current_workout_data.dart';
import 'package:gympanion/features/prs/providers/pr_manager.dart';
import 'package:gympanion/features/sleep/providers/sleep_manager.dart';
import 'package:gympanion/core/data/user_data.dart';
import 'package:gympanion/features/stats/providers/user_stats.dart';
import 'package:gympanion/features/workouts/models/workouts_data.dart';
import 'package:gympanion/features/auth/auth_gate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserData>(
        create: (context) => UserData(),
      ),
      ChangeNotifierProvider<AppData>(
        create: (context) => AppData(),
      ),
      ChangeNotifierProvider<CurrentWorkoutData>(
        create: (context) => CurrentWorkoutData(),
      ),
      ChangeNotifierProvider<CurrentCardioData>(
        create: (context) => CurrentCardioData(),
      ),
      ChangeNotifierProvider<FirebaseAuthServices>(
        create: (context) => FirebaseAuthServices(FirebaseAuth.instance),
      ),
      ChangeNotifierProvider<UserStats>(
        create: (context) => UserStats(),
      ),
      ChangeNotifierProvider<SleepManager>(
        create: (context) => SleepManager(),
      ),
      ChangeNotifierProvider<PRManager>(
        create: (context) => PRManager()..init(),
        lazy: false,
      ),
      ChangeNotifierProvider<WorkoutsData>(
        create: (context) => WorkoutsData()..init(),
        lazy: false,
      ),
    ],
    child: Gympanion(),
  ));
}

class Gympanion extends StatelessWidget {
  const Gympanion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: context.select<AppData, bool>(
        (appData) => appData.isDarkMode,
      )
          ? ThemeData.dark().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Poppins',
                  ),
            )
          : ThemeData.light().copyWith(
              textTheme: ThemeData.dark().textTheme.apply(
                    fontFamily: 'Poppins',
                  ),
            ),
      // home: StartingPage(),

      home: AuthGate(),
    );
  }
}
