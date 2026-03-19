import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/views/data/data_storage.dart';

class SleepRecord {
  DateTime? date;
  TimeOfDay? from;
  TimeOfDay? to;
  Duration duration;
  double rating;

  SleepRecord(this.date, this.from, this.to, this.duration, this.rating);

  Map<String, dynamic> toJson() {
    return {
      'dateFinished': date,
      'from': from!.hour * 60 + from!.minute,
      'to': to!.hour * 60 + to!.minute,
      'duration': duration.inMinutes,
      'rating': rating
    };
  }

  factory SleepRecord.fromJson(Map<String, dynamic> json) {
    final date = json['dateFinished'];
    final startHour = ((json['from'] / 60) as double).toInt();
    final startMins = json['from'] % 60;
    final endHour = ((json['to'] / 60) as double).toInt();
    final endMins = json['to'] % 60;

    return SleepRecord(
      date is Timestamp ? date.toDate() : null,
      TimeOfDay(hour: startHour, minute: startMins),
      TimeOfDay(hour: endHour, minute: endMins),
      Duration(minutes: json['duration']),
      double.parse(json['rating'].toString()),
    );
  }
}

class SleepManager extends ChangeNotifier {
  final List<SleepRecord> _sleepRecords = [];

  List<SleepRecord> get sleepRecords => _sleepRecords;

  SleepManager();

  void addSleepRecord(SleepRecord sleepRecord) {
    _sleepRecords.add(sleepRecord);

    DataStorage.saveJSONFireBase('sleep_records', sleepRecord.toJson());
    notifyListeners();
  }
}
