import 'package:flutter/material.dart';
import 'package:gympanion/core/data/data_storage.dart';

class ExerciseSet {
  int weight = 0;
  int numberOfReps = 0;
  bool isDone = false;
  bool isDropSet = false;
  List<ExerciseSet> dropSets = [];

  ExerciseSet({required this.numberOfReps, required this.weight});
  Map<String, dynamic> toJson() => {
        'weight': weight,
        'numberOfReps': numberOfReps,
        'isDone': isDone,
        'isDropSet': isDropSet,
        'dropSets': dropSets
            .map(
              (element) => element.toJson(),
            )
            .toList()
      };

  ExerciseSet.fromJson(Map<String, dynamic> json) {
    numberOfReps = json['numberOfReps'] ?? 0;
    weight = json['weight'] ?? 0;
    isDone = json['isDone'] ?? false;
    isDropSet = json['isDropSet'] ?? false;
    if (json['dropSets'] != null) {
      dropSets.clear();
      dropSets.addAll((json['dropSets'] as List)
          .map((e) => ExerciseSet.fromJson(e))
          .toList());
    }
  }
}

class Exercise {
  String title = '';
  String muscleGroup = '';
  bool selected = false;
  List<ExerciseSet> sets = [];
  Exercise({this.title = '', this.muscleGroup = ''});

  void toggleExercise() {
    selected = !selected;
  }

  void resetSelected() {
    if (selected) selected = false;
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'selected': selected,
        'muscleGroup': muscleGroup,
        'sets': sets.map((e) => e.toJson()).toList()
      };

  Exercise.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    selected = json['selected'] ?? false;
    muscleGroup = json['muscleGroup'] ?? '';
    if (json['sets'] != null) {
      sets.clear();
      sets.addAll(
          (json['sets'] as List).map((e) => ExerciseSet.fromJson(e)).toList());
    }
  }
}

class WorkoutsData extends ChangeNotifier {
  // Future<void> seedExercises() async {
  //   final exercises = [
  //     // Chest
  //     {"name": "Barbell Bench Press", "muscleGroup": "Chest"},
  //     {"name": "Incline Dumbbell Press", "muscleGroup": "Chest"},
  //     {"name": "Flat Dumbbell Press", "muscleGroup": "Chest"},
  //     {"name": "Cable Chest Fly", "muscleGroup": "Chest"},
  //     {"name": "Machine Chest Press", "muscleGroup": "Chest"},
  //     {"name": "Pec Deck", "muscleGroup": "Chest"},
  //     {"name": "Chest Dips", "muscleGroup": "Chest"},
  //     {"name": "Push-ups", "muscleGroup": "Chest"},

  //     // Back
  //     {"name": "Lat Pulldown", "muscleGroup": "Back"},
  //     {"name": "Pull-ups", "muscleGroup": "Back"},
  //     {"name": "Assisted Pull-ups", "muscleGroup": "Back"},
  //     {"name": "Barbell Row", "muscleGroup": "Back"},
  //     {"name": "Dumbbell Row", "muscleGroup": "Back"},
  //     {"name": "Seated Cable Row", "muscleGroup": "Back"},
  //     {"name": "T-Bar Row", "muscleGroup": "Back"},
  //     {"name": "Face Pull", "muscleGroup": "Back"},

  //     // Shoulders
  //     {"name": "Overhead Barbell Press", "muscleGroup": "Shoulders"},
  //     {"name": "Dumbbell Shoulder Press", "muscleGroup": "Shoulders"},
  //     {"name": "Arnold Press", "muscleGroup": "Shoulders"},
  //     {"name": "Lateral Raises", "muscleGroup": "Shoulders"},
  //     {"name": "Rear Delt Fly", "muscleGroup": "Shoulders"},
  //     {"name": "Upright Row", "muscleGroup": "Shoulders"},
  //     {"name": "Machine Shoulder Press", "muscleGroup": "Shoulders"},

  //     // Biceps
  //     {"name": "Barbell Curl", "muscleGroup": "Biceps"},
  //     {"name": "Dumbbell Curl", "muscleGroup": "Biceps"},
  //     {"name": "Hammer Curl", "muscleGroup": "Biceps"},
  //     {"name": "Preacher Curl", "muscleGroup": "Biceps"},
  //     {"name": "Cable Curl", "muscleGroup": "Biceps"},

  //     // Triceps
  //     {"name": "Tricep Pushdown", "muscleGroup": "Triceps"},
  //     {"name": "Overhead Tricep Extension", "muscleGroup": "Triceps"},
  //     {"name": "Skull Crushers", "muscleGroup": "Triceps"},
  //     {"name": "Close Grip Bench Press", "muscleGroup": "Triceps"},
  //     {"name": "Tricep Dips", "muscleGroup": "Triceps"},

  //     // Legs
  //     {"name": "Barbell Squat", "muscleGroup": "Legs"},
  //     {"name": "Leg Press", "muscleGroup": "Legs"},
  //     {"name": "Hack Squat", "muscleGroup": "Legs"},
  //     {"name": "Romanian Deadlift", "muscleGroup": "Legs"},
  //     {"name": "Leg Curl", "muscleGroup": "Legs"},
  //     {"name": "Leg Extension", "muscleGroup": "Legs"},
  //     {"name": "Walking Lunges", "muscleGroup": "Legs"},
  //     {"name": "Bulgarian Split Squat", "muscleGroup": "Legs"},
  //     {"name": "Standing Calf Raises", "muscleGroup": "Legs"},
  //     {"name": "Seated Calf Raises", "muscleGroup": "Legs"},

  //     // Core
  //     {"name": "Plank", "muscleGroup": "Core"},
  //     {"name": "Hanging Leg Raises", "muscleGroup": "Core"},
  //     {"name": "Cable Crunch", "muscleGroup": "Core"},
  //     {"name": "Russian Twist", "muscleGroup": "Core"},
  //     {"name": "Ab Wheel Rollout", "muscleGroup": "Core"},
  //   ];

  //   for (var ex in exercises) {
  //     await FirebaseFirestore.instance
  //         .collection('workouts')
  //         .doc(ex['name'])
  //         .set(ex);
  //   }
  // }

  // final Map<String, List<Exercise>> _workouts = {
  //   'Push': [
  //     Exercise(title: 'Chest Press'),
  //     Exercise(title: 'Incline Chest Press'),
  //     Exercise(title: 'Shoulder Press'),
  //     Exercise(title: 'Triceps Pushdown'),
  //     Exercise(title: 'Lateral Raises'),
  //     Exercise(title: 'Front Raises'),
  //   ],
  //   'Pull': [
  //     Exercise(title: 'Lat Pulldown'),
  //     Exercise(title: 'Cable Rows'),
  //     Exercise(title: 'High Rows'),
  //     Exercise(title: 'Back Extension'),
  //     Exercise(title: 'Biceps Curls'),
  //     Exercise(title: 'Preacher Curls'),
  //     Exercise(title: 'Face Pulls'),
  //     Exercise(title: 'Rear Delts')
  //   ],
  //   'Legs': [
  //     Exercise(title: 'Leg Extentions'),
  //     Exercise(title: 'Hack Squats'),
  //     Exercise(title: 'Leg Curls'),
  //     Exercise(title: 'Calves'),
  //     Exercise(title: 'Abduction'),
  //     Exercise(title: 'Adduction')
  //   ],
  //   'Chest': [
  //     Exercise(title: 'Chest Press'),
  //     Exercise(title: 'Incline Chest Press'),
  //     Exercise(title: 'Chest Flys')
  //   ],
  //   'Shoulders': [
  //     Exercise(title: 'Shoulder Press'),
  //     Exercise(title: 'Lateral Raises'),
  //     Exercise(title: 'Front Raises')
  //   ],
  //   'Arms': [
  //     Exercise(title: 'Triceps Pushdown'),
  //     Exercise(title: 'Biceps Curls')
  //   ],
  //   'Core': [Exercise(title: 'Deadlifts'), Exercise(title: 'Crunches')],
  // };

  final Map<String, List<Exercise>> _workouts = {};
  Map<String, List<Exercise>> get workouts => _workouts;
  bool workotsLoaded = false;

  Future<void> init() async {
    await getWorkoutsFromFirebase();
  }

  Future<void> getWorkoutsFromFirebase() async {
    if (workotsLoaded) return;
    final data = await DataStorage.getJSONCollectionFirebase('workouts',
        userLevel: false);
    loadFromJson(data);
    workotsLoaded = true;
    notifyListeners();
  }

  void resetExercises() {
    for (var element in _workouts.values) {
      for (var e in element) {
        e.resetSelected();
      }
    }
    notifyListeners();
  }

  // List<Exercise>? getCategoryExercises(String value) {
  //   // _selectedCategory = value;
  //   return _workouts[value] ?? List.empty();
  // }

  int findExerciseIndexInWorkoutDay(Exercise e, String workoutDayName) {
    return _workouts[workoutDayName]
            ?.indexWhere((exercise) => exercise.title == e.title) ??
        -1;
  }

  Map<String, dynamic> toJson() {
    return _workouts.map((category, exercises) {
      return MapEntry(
        category,
        exercises.map((e) => e.toJson()).toList(),
      );
    });
  }

  void loadFromJson(List<Map<String, dynamic>>? data) {
    for (var workout in data!) {
      _workouts.putIfAbsent(workout['muscleGroup'], () => []);
      _workouts[workout['muscleGroup']]?.add(Exercise(
          title: workout['name'], muscleGroup: workout['muscleGroup']));
    }
  }
}
