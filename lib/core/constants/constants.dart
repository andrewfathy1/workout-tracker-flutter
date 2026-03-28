import 'package:flutter/material.dart';

enum TrainingMode { none, workout, cardio }

enum Goals { stayHealthy, loseWeight, gainWeight, gainMuscles }

final workoutRatings = {
  "Poor": "😞",
  "Average": "😐",
  "Good": "🙂",
  "Excellent": "🤩",
};

enum EditingValueType { reps, weight }

enum EditingValuesKeys {
  mainRep('currentMainRepCount', EditingValueType.reps),
  mainWeight('currentMainWeight', EditingValueType.weight),
  dropsetRep1('currentDropsetRepCount1', EditingValueType.reps),
  dropsetWeight1('currentDropsetWeight1', EditingValueType.weight),
  dropsetRep2('currentDropsetRepCount2', EditingValueType.reps),
  dropsetWeight2('currentDropsetWeight2', EditingValueType.weight),
  nonIndexedDropsetReps('currentDropsetRepCount', EditingValueType.reps),
  nonIndexedDropsetWeight('currentDropsetWeight', EditingValueType.weight);

  final String key;
  final EditingValueType type;
  const EditingValuesKeys(this.key, this.type);
}

const int minAge = 15;
const int maxAge = 90;

const List<String> goals = [
  'Stay Healthy',
  'Lose Weight',
  'Gain Weight',
  'Gain Muscles'
];

class AppColors {
  static const Color backgroundColor = Color(0xFF0F1115);
  static const Color accentColor = Color(0xFF5E72EB);
  static const Color cardColor = Color(0xFF1A1D24);

  static const Color workoutColor = Color.fromARGB(255, 201, 110, 130);

  static const Color cardioColor = Color.fromARGB(255, 142, 204, 144);
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF9CA3AF);

  // static const Color temp1 = Color.fromARGB(255, 116, 130, 194);
  // static const Color temp2 = Color.fromARGB(255, 235, 225, 143);
}

class AppTextStyles {
  // Titles / Headings
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
  );

  // Body Text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryText,
  );

  // Captions / Hints
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  // Button text
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryText,
  );
}
