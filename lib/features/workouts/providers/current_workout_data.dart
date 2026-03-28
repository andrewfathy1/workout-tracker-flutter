import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/core/data/data_storage.dart';
import 'package:gympanion/features/workouts/models/workouts_data.dart';
import 'package:intl/intl.dart';
import 'package:gympanion/core/data/notifiers.dart';

class CurrentWorkoutData with ChangeNotifier {
  String workoutDayName = '';
  bool _workoutStarted = false;
  Duration _timeElapsed = Duration();
  String _formattedTimer = '';
  final List<Exercise> _currentExercises = [];
  String _dateFinished = '';
  String workoutRating = '';
  // int _currentRepCountValue = 10;
  // int _currentWeightValue = 10;
  Timer? _timer;
  Map<String, dynamic> _editingValues = {
    EditingValuesKeys.mainRep.key: 10,
    EditingValuesKeys.mainWeight.key: 10,
    EditingValuesKeys.dropsetRep1.key: 10,
    EditingValuesKeys.dropsetWeight1.key: 10,
    EditingValuesKeys.dropsetRep2.key: 10,
    EditingValuesKeys.dropsetWeight2.key: 10
  };

  bool get workoutStarted => _workoutStarted;
  Duration get timeElapsed => _timeElapsed;
  String get formattedTimer => _formattedTimer;
  List<Exercise> get currentExercises => _currentExercises;
  String get dateFinished => _dateFinished;
  Map<String, dynamic> get editingValues => _editingValues;
  // int get currentRepCountValue => _currentRepCountValue;
  // int get currentWeightValue => _currentWeightValue;

  static ValueNotifier<String> timerText = ValueNotifier<String>('00:00:00');
  CurrentWorkoutData() {
    getCurrentWorkoutLocally();
  }

  void selectWhichDay(String value) {
    workoutDayName = value;
    notifyListeners();
  }

  void startWorkout() {
    if (_workoutStarted) return;
    _workoutStarted = true;
    currentTrainingMode.value = TrainingMode.workout;
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _timeElapsed += Duration(seconds: 1);
        _formattedTimer = formatTimer(_timeElapsed);
        timerText.value = _formattedTimer;
      },
    );

    _timeElapsed = Duration.zero;
    DataStorage.saveJSONLocally('currentWorkoutData', toJson());
    autoSaveLocally();
    notifyListeners();
  }

  void resumeWorkout() {
    currentTrainingMode.value = TrainingMode.workout;

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _timeElapsed += Duration(seconds: 1);
        _formattedTimer = formatTimer(_timeElapsed);
        timerText.value = _formattedTimer;
      },
    );
    autoSaveLocally();
  }

  void endWorkout() async {
    _dateFinished = DateFormat('MMM d, y').format(DateTime.now());
    DataStorage.saveJSONFireBase('user_workouts', toJson());
    workoutDayName = '';
    _workoutStarted = false;
    _currentExercises.clear();
    _formattedTimer = '00:00:00';
    timerText.value = '00:00:00';
    _timer?.cancel();
    currentTrainingMode.value = TrainingMode.none;

    await DataStorage.removeJSONLocally('currentWorkoutData');
    notifyListeners();
  }

  void resetSelectedExercises() {
    _currentExercises.clear();
    workoutDayName = '';
    _workoutStarted = false;
    currentTrainingMode.value = TrainingMode.none;

    notifyListeners();
  }

  void addExercise(Exercise exercise) {
    _currentExercises.add(exercise);
    // DataStorage.saveJSONLocally('currentWorkoutData', toJson());
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    _currentExercises.remove(exercise);
    // DataStorage.saveJSONLocally('currentWorkoutData', toJson());

    notifyListeners();
  }

  void addSetToExercise(Exercise e) {
    int index = findExerciseIndex(e);
    if (index == -1) return;
    _currentExercises[index].sets.add(ExerciseSet(
        numberOfReps: _editingValues[EditingValuesKeys.mainRep.key] ?? 0,
        weight: _editingValues[EditingValuesKeys.mainWeight.key] ?? 0));
    DataStorage.saveJSONLocally('currentWorkoutData', toJson());

    notifyListeners();
  }

  void markSetAsDone(Exercise exercise, int setNumber) {
    int index = findExerciseIndex(exercise);
    if (index == -1) return;
    _currentExercises[index].sets[setNumber].isDone = true;
    DataStorage.saveJSONLocally('currentWorkoutData', toJson());

    notifyListeners();
  }

  void removeSet(Exercise exercise, int setNumber) {
    int index = findExerciseIndex(exercise);
    if (index == -1) return;
    _currentExercises[index].sets.removeAt(setNumber);
    DataStorage.saveJSONLocally('currentWorkoutData', toJson());

    notifyListeners();
  }

  void editSet(Exercise exercise, int setIndex, bool isDropSet) {
    int index = findExerciseIndex(exercise);
    if (index == -1) return;
    ExerciseSet set = _currentExercises[index].sets[setIndex];

    set.numberOfReps = _editingValues[EditingValuesKeys.mainRep.key] ?? 0;
    set.weight = _editingValues[EditingValuesKeys.mainWeight.key] ?? 0;
    set.isDropSet = isDropSet;

    if (set.isDropSet) {
      for (int i = 0; i < set.dropSets.length; i++) {
        set.dropSets[i].numberOfReps = _editingValues[
            EditingValuesKeys.nonIndexedDropsetReps.key + (i + 1).toString()];
        set.dropSets[i].weight = _editingValues[
            EditingValuesKeys.nonIndexedDropsetWeight.key + (i + 1).toString()];
      }
    }
    DataStorage.saveJSONLocally('currentWorkoutData', toJson());

    notifyListeners();
  }

  void setRepEditingValue(String key, int value) {
    if (value < 0) value = 0;
    if (value > 30) value = 30;
    _editingValues[key] = value;
    notifyListeners();
  }

  void setWeightEditingValue(String key, int value) {
    if (value < 0) value = 0;
    if (value > 300) value = 300;
    _editingValues[key] = value;
    notifyListeners();
  }

  int findExerciseIndex(Exercise e) {
    return _currentExercises
        .indexWhere((exercise) => exercise.title == e.title);
  }

  String formatTimer(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Map<String, dynamic> toJson() => {
        'workoutDayName': workoutDayName,
        'activityName': workoutDayName,
        'workoutStarted': _workoutStarted,
        'timeElapsed': _timeElapsed.inSeconds,
        'currentExercises': _currentExercises.map((e) => e.toJson()).toList(),
        'editingValues': _editingValues,
        'dateFinished': _dateFinished,
        'rating': workoutRating
      };

  CurrentWorkoutData.fromJson(Map<String, dynamic> json) {
    workoutDayName = json['workoutDayName'] ?? '';
    _workoutStarted = json['workoutStarted'] ?? false;
    _timeElapsed = Duration(seconds: json['timeElapsed'] ?? 0);
    _editingValues = json['editingValues'] ?? {};
    workoutRating = json['rating'] ?? '';
    if (json['currentExercises'] != null) {
      _currentExercises.clear();
      _currentExercises.addAll((json['currentExercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList());
    }
  }

  // static SharedPreferences? _prefs;

  // Future<SharedPreferences> _getPrefs() async {
  //   _prefs ??= await SharedPreferences.getInstance();
  //   return _prefs!;
  // }

  // Future<void> saveCurrentWorkoutLocally() async {
  //   print('saved changes');
  //   // debugPrint("notifyListeners() called");
  //   // debugPrint(StackTrace.current.toString()); // print call stack
  //   final prefs = await _getPrefs();
  //   prefs.setString('currentWorkoutData', jsonEncode(toJson()));
  // }

  void autoSaveLocally() {
    Timer.periodic(
      Duration(seconds: 30),
      (timer) {
        if (_workoutStarted) {
          DataStorage.saveJSONLocally('currentWorkoutData', toJson());
        }
      },
    );
  }

  // Future<void> removeCurrentWorkoutLocally() async {
  //   final prefs = await _getPrefs();
  //   prefs.remove('currentWorkoutData');
  // }

  Future<void> getCurrentWorkoutLocally() async {
    // final prefs = await _getPrefs();
    // String json = prefs.getString('currentWorkoutData') ?? '';
    Map<String, dynamic> json =
        await DataStorage.getJSONLocally('currentWorkoutData');
    // print('Jsoooooooooon = $json');
    print('Jsoooooooooon = $json');
    if (json.isNotEmpty) {
      loadFrom(CurrentWorkoutData.fromJson(json));
      resumeWorkout();
    }
  }

  void loadFrom(CurrentWorkoutData other) {
    workoutDayName = other.workoutDayName;
    _workoutStarted = other._workoutStarted;
    _timeElapsed = other._timeElapsed;
    _formattedTimer = other._formattedTimer;
    _editingValues = other._editingValues;

    _currentExercises
      ..clear()
      ..addAll(other._currentExercises);

    notifyListeners();
  }
}
