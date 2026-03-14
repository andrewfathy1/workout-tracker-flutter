import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';
// part 'exercise_pr.g.dart';

// @JsonSerializable()
class ExercisePR {
  final String exerciseName;
  double oneRM;
  double volume;
  bool isSeen = false;
  final DateTime? oneRMDate;
  final DateTime? volumeDate;

  ExercisePR(
      {required this.exerciseName,
      required this.oneRM,
      required this.volume,
      this.oneRMDate,
      this.volumeDate});

  factory ExercisePR.fromJson(Map<String, dynamic> json, String exerciseName) {
    final oneRMTimestamp = json['oneRMDate'];
    final volumeTimestamp = json['volumeDate'];

    return ExercisePR(
      exerciseName: exerciseName,
      oneRM: (json['oneRM'] as num).toDouble(),
      volume: (json['volume'] as num).toDouble(),
      oneRMDate: oneRMTimestamp is Timestamp ? oneRMTimestamp.toDate() : null,
      volumeDate:
          volumeTimestamp is Timestamp ? volumeTimestamp.toDate() : null,
    )..isSeen = (json['isSeen'] ?? false) as bool;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'exerciseName': exerciseName,
        'oneRM': oneRM,
        'volume': volume,
        'isSeen': isSeen,
        'oneRMDate': oneRMDate,
        'volumeDate': volumeDate
      };
}
