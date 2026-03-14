import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/views/data/prs/exercise_pr.dart';
import 'package:intl/intl.dart';

class UserStats with ChangeNotifier {
  List<Map<String, dynamic>> _previousWorkouts = [];
  List<Map<String, dynamic>> _thisWeekWorkouts = [];

  List<Map<String, dynamic>> _previousCardio = [];
  List<Map<String, dynamic>> _thisWeekCardio = [];

  List<Map<String, dynamic>> _sleepRecords = [];
  List<Map<String, dynamic>> get sleepRecords => _sleepRecords;

  final Map<String, List<ExercisePR>> _previousPRs = {};

  int _previousWorkoutsCount = 0;
  String _lastWorkoutTitle = '';
  int _previousCardioCount = 0;
  String _lastCardioTitle = '';

  List<Map<String, dynamic>> get previousWorkouts => _previousWorkouts;
  List<Map<String, dynamic>> get thisWeekWorkouts => _thisWeekWorkouts;

  List<Map<String, dynamic>> get previousCardio => _previousCardio;
  List<Map<String, dynamic>> get thisWeekCardio => _thisWeekCardio;

  Map<String, List<ExercisePR>> get previousPRs => _previousPRs;

  int get previousWorkoutsCount => _previousWorkoutsCount;
  String get lastWorkoutTitle => _lastWorkoutTitle;

  int get previousCardiosCount => _previousCardioCount;
  String get lastCardioTitle => _lastCardioTitle;

  StreamSubscription? _workoutSubscription;
  StreamSubscription? _cardioSubscription;
  StreamSubscription? _prSubscription;
  StreamSubscription? _sleepRecordsSubscription;

  UserStats() {
    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user != null) {
          _listenToChanges();
        }
      },
    );
  }

  void reloadUserStats() {
    _listenToChanges();
  }

  void _listenToChanges() {
    _workoutSubscription = _getStreamSubscription(
      'user_workouts',
      (snapshot) {
        _previousWorkoutsCount = snapshot.docs.length;
        _previousWorkouts = snapshot.docs
            .map(
              (doc) => doc.data(),
            )
            .toList();
        _thisWeekWorkouts = filterThisWeeksActivities(_previousWorkouts);
        if (_previousWorkouts.isNotEmpty) {
          _lastWorkoutTitle = _previousWorkouts.last['workoutDayName'];
        } else {
          _lastWorkoutTitle = 'No workouts yet!';
        }
        notifyListeners();
      },
    );
    _cardioSubscription = _getStreamSubscription(
      'user_cardio_sessions',
      (snapshot) {
        _previousCardioCount = snapshot.docs.length;
        _previousCardio = snapshot.docs
            .map(
              (doc) => doc.data(),
            )
            .toList();
        _thisWeekCardio = filterThisWeeksActivities(_previousCardio);
        if (_previousCardio.isNotEmpty) {
          _lastCardioTitle = _previousCardio.last['cardioTitle'];
        } else {
          _lastCardioTitle = 'No Cardio yet!';
        }
        notifyListeners();
      },
    );
    _prSubscription = _getStreamSubscription('prs', (snapshot) {
      for (final doc in snapshot.docs) {
        final categoryName = doc.id;
        final exercises =
            doc.data().entries.where((e) => e.value is Map).map((entry) {
          final map = Map<String, dynamic>.from(entry.value as Map);

          return ExercisePR.fromJson(map, entry.key);
        }).toList();

        _previousPRs[categoryName] = exercises;
      }
      notifyListeners();
    });

    _sleepRecordsSubscription = _getStreamSubscription(
      'sleep_records',
      (snapshot) {
        _sleepRecords = snapshot.docs
            .map(
              (doc) => doc.data(),
            )
            .toList();

        notifyListeners();
      },
    );
  }

  StreamSubscription _getStreamSubscription(String collectionName,
      Function(QuerySnapshot<Map<String, dynamic>>) onData) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.displayName! +
            FirebaseAuth.instance.currentUser!.uid)
        .collection(collectionName)
        .snapshots()
        .listen(onData);
  }

  @override
  void dispose() {
    _workoutSubscription?.cancel();
    _cardioSubscription?.cancel();
    _prSubscription?.cancel();
    _sleepRecordsSubscription?.cancel();
    super.dispose();
  }

  List<Map<String, dynamic>> filterThisWeeksActivities(
      List<Map<String, dynamic>> activities) {
    final now = DateTime.now();

    // Saturday = start of week
    int daysSinceSaturday = now.weekday % 7;

    final startOfWeek = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: daysSinceSaturday));

    final endOfWeek = startOfWeek.add(
      const Duration(days: 6, hours: 23, minutes: 59, seconds: 59),
    );

    final dateFormat = DateFormat('MMM dd, yyyy');

    return activities.where((activity) {
      final dateStr = activity['dateFinished'] as String?;
      if (dateStr == null) return false;

      try {
        final activityDate = dateFormat.parse(dateStr);

        return !activityDate.isBefore(startOfWeek) &&
            !activityDate.isAfter(endOfWeek);
      } catch (_) {
        return false;
      }
    }).toList();
  }
}
