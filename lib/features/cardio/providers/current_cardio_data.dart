import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gympanion/core/constants/constants.dart';
import 'package:gympanion/core/data/data_storage.dart';
import 'package:gympanion/core/data/notifiers.dart';
import 'package:intl/intl.dart';

class CurrentCardioData with ChangeNotifier {
  String cardioTitle = '';
  bool _cardioStarted = false;
  Duration _timeElapsed = Duration();
  String _formattedTimer = '';
  String _dateFinished = '';
  String cardioSessionRating = '';
  Timer? _timer;

  bool get cardioStarted => _cardioStarted;
  Duration get timeElapsed => _timeElapsed;
  String get formattedTimer => _formattedTimer;
  String get dateFinished => _dateFinished;

  static ValueNotifier<String> timerText = ValueNotifier<String>('00:00:00');
  CurrentCardioData() {
    getCurrentCardioLocally();
  }

  void selectWhichCardio(String value) {
    cardioTitle = value;
    notifyListeners();
  }

  void startCardio() {
    if (_cardioStarted) return;

    _cardioStarted = true;
    currentTrainingMode.value = TrainingMode.cardio;

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        _timeElapsed += Duration(seconds: 1);
        _formattedTimer = formatTimer(_timeElapsed);
        timerText.value = _formattedTimer;
      },
    );

    _timeElapsed = Duration.zero;
    DataStorage.saveJSONLocally('currentCardioData', toJson());
    autoSaveLocally();
    notifyListeners();
  }

  void resumeCardio() {
    currentTrainingMode.value = TrainingMode.cardio;

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

  Future<void> endCardio() async {
    _dateFinished = DateFormat('MMM d, y').format(DateTime.now());
    currentTrainingMode.value = TrainingMode.none;

    await DataStorage.saveJSONFireBase('user_cardio_sessions', toJson());
    cardioTitle = '';
    _cardioStarted = false;
    _formattedTimer = '00:00:00';
    timerText.value = '00:00:00';
    _timer?.cancel();
    await DataStorage.removeJSONLocally('currentCardioData');
    notifyListeners();
  }

  String formatTimer(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Map<String, dynamic> toJson() => {
        'cardioTitle': cardioTitle,
        'activityName': cardioTitle,
        'cardioStarted': _cardioStarted,
        'timeElapsed': _timeElapsed.inSeconds,
        'dateFinished': _dateFinished,
        'rating': cardioSessionRating
      };

  CurrentCardioData.fromJson(Map<String, dynamic> json) {
    cardioTitle = json['cardioTitle'] ?? '';
    _cardioStarted = json['cardioStarted'] ?? false;
    _timeElapsed = Duration(seconds: json['timeElapsed'] ?? 0);
    cardioSessionRating = json['rating'] ?? '';
  }

  void autoSaveLocally() {
    Timer.periodic(
      Duration(seconds: 30),
      (timer) {
        if (_cardioStarted) {
          DataStorage.saveJSONLocally('currentCardioData', toJson());
        }
      },
    );
  }

  // Future<void> removeCurrentWorkoutLocally() async {
  //   final prefs = await _getPrefs();
  //   prefs.remove('currentWorkoutData');
  // }

  Future<void> getCurrentCardioLocally() async {
    Map<String, dynamic> json =
        await DataStorage.getJSONLocally('currentCardioData');
    print('Jsoooooooooonaaaaaaaaaaaaaaaaaaaaaa = $json');
    if (json.isNotEmpty) {
      loadFrom(CurrentCardioData.fromJson(json));
      resumeCardio();
    }
  }

  void loadFrom(CurrentCardioData other) {
    cardioTitle = other.cardioTitle;
    _cardioStarted = other._cardioStarted;
    _timeElapsed = other._timeElapsed;
    _formattedTimer = other._formattedTimer;

    notifyListeners();
  }
}
