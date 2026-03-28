import 'package:gympanion/core/data/data_storage.dart';

class CardioData {
  List<String> _cardioData = [];
  List<String> get cardioData => _cardioData;

  CardioData();
  Future<void> getCardioDataFromFirebase() async {
    final data = await DataStorage.getJSONDocumentFirebase(
        'cardio', 'cardio_exercises',
        userLevel: false);
    loadFromJson(data);
  }

  // List<Exercise>? getCategoryExercises(String value) {
  //   // _selectedCategory = value;
  //   return _workouts[value] ?? List.empty();
  // }

  // int findExerciseIndexInWorkoutDay(Exercise e, String workoutDayName) {
  //   return _workouts[workoutDayName]
  //           ?.indexWhere((exercise) => exercise.title == e.title) ??
  //       -1;
  // }

  // Map<String, dynamic> toJson() {
  //   return _workouts.map((category, exercises) {
  //     return MapEntry(
  //       category,
  //       exercises.map((e) => e.toJson()).toList(),
  //     );
  //   });
  // }

  void loadFromJson(Map<String, dynamic>? data) {
    _cardioData = (data?['cardio_list'] as List)
        .map(
          (e) => e.toString(),
        )
        .toList();
  }
}
