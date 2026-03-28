import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';

ValueNotifier<String> userName = ValueNotifier('');
ValueNotifier<int> userAge = ValueNotifier(15);
ValueNotifier<String> selectedGoal = ValueNotifier('');
ValueNotifier<TrainingMode> currentTrainingMode =
    ValueNotifier(TrainingMode.none);
ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
ValueNotifier<TimeOfDay?> selectedTime1 = ValueNotifier(null);
ValueNotifier<TimeOfDay?> selectedTime2 = ValueNotifier(null);
ValueNotifier<Duration?> sleepDuration = ValueNotifier(null);
ValueNotifier<double> sleepRating = ValueNotifier(0);
