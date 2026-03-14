import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympanion/views/data/data_storage.dart';
import 'package:gympanion/views/data/prs/exercise_pr.dart';
import 'package:collection/collection.dart';

class PRManager extends ChangeNotifier {
  Map<String, List<ExercisePR>> groupedPRs = {};
  late StreamSubscription streamSubscription;
  // Map<String, Map<String, List<Map<String, double>>>> prRecords = {};

  void init() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
    streamSubscription = _getGroupedPRsStream();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  StreamSubscription _getGroupedPRsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.displayName! +
            FirebaseAuth.instance.currentUser!.uid)
        .collection('prs')
        .snapshots()
        .listen((snapshot) {
      for (final doc in snapshot.docs) {
        final categoryName = doc.id;
        final exercises =
            doc.data().entries.where((e) => e.value is Map).map((entry) {
          print('${entry.value} =========aaaaaaaaaaaaaaaaaaaaa===');
          final map = Map<String, dynamic>.from(entry.value as Map);
          return ExercisePR.fromJson(map, entry.key);
        }).toList();

        groupedPRs[categoryName] = exercises;
      }
    });
  }

  bool addPRRecordEntry(String exerciseTitle, String exerciseCategory,
      int repCount, double weight) {
    bool categoryExist = groupedPRs.containsKey(exerciseCategory);
    final oneRMPR = _calculateOneRMPR(repCount, weight);
    final volumePR = _calculateVolumePR(repCount, weight);
    bool isNewRecord = false;
    if (categoryExist) {
      ExercisePR? exercisePR = groupedPRs[exerciseCategory]!.firstWhereOrNull(
        (element) => element.exerciseName == exerciseTitle,
      );

      if (exercisePR != null) {
        if (exercisePR.oneRM < oneRMPR) {
          exercisePR.oneRM = oneRMPR;
          exercisePR.isSeen = false;
          isNewRecord = true;
          saveRecordFirebase(
            exerciseCategory,
            exercisePR.toJson(),
          );
        }
        if (exercisePR.volume < volumePR) {
          exercisePR.volume = volumePR;
          exercisePR.isSeen = false;

          isNewRecord = true;

          saveRecordFirebase(
            exerciseCategory,
            exercisePR.toJson(),
          );
        }
      } else {
        groupedPRs[exerciseCategory]!.add(ExercisePR(
            exerciseName: exerciseTitle,
            oneRM: oneRMPR,
            volume: volumePR,
            oneRMDate: DateTime.now(),
            volumeDate: DateTime.now()));
        isNewRecord = true;

        saveRecordFirebase(
          exerciseCategory,
          ExercisePR(
                  exerciseName: exerciseTitle,
                  oneRM: oneRMPR,
                  volume: volumePR,
                  oneRMDate: DateTime.now(),
                  volumeDate: DateTime.now())
              .toJson(),
        );
      }
    } else {
      groupedPRs.putIfAbsent(
        exerciseCategory,
        () => [],
      );
      isNewRecord = true;

      saveRecordFirebase(
        exerciseCategory,
        ExercisePR(
                exerciseName: exerciseTitle,
                oneRM: oneRMPR,
                volume: volumePR,
                oneRMDate: DateTime.now(),
                volumeDate: DateTime.now())
            .toJson(),
      );
    }
    return isNewRecord;
  }

  double _calculateOneRMPR(int repCount, double weight) {
    return (repCount * weight * 0.0333) + weight;
  }

  double _calculateVolumePR(int repCount, double weight) {
    return (repCount * weight);
  }

  void saveRecordFirebase(
      String categoryName, Map<String, dynamic> recordJson) {
    recordJson['volumeDate'] = FieldValue.serverTimestamp();
    recordJson['oneRMDate'] = FieldValue.serverTimestamp();
    Map<String, dynamic> newmap = {recordJson['exerciseName']: recordJson};

    DataStorage.saveJSONFireBase('prs', newmap, docName: categoryName);
  }

  markPRRead(String categoryName, int prIndex) {
    groupedPRs[categoryName]?[prIndex].isSeen = true;
    saveRecordFirebase(
        categoryName, groupedPRs[categoryName]![prIndex].toJson());
    notifyListeners();
  }
}
