import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static SharedPreferences? _prefs;

  static Future<void> saveJSONLocally(
      String key, Map<String, dynamic> json) async {
    print('saved changes');
    _prefs = _prefs ??= await SharedPreferences.getInstance();
    _prefs?.setString(key, jsonEncode(json));
  }

  static Future<Map<String, dynamic>> getJSONLocally(String key) async {
    _prefs = _prefs ??= await SharedPreferences.getInstance();
    String json = _prefs?.getString(key) ?? '';
    if (json != '') {
      return jsonDecode(json);
    } else {
      return <String, dynamic>{};
    }
  }

  static Future<void> removeJSONLocally(String key) async {
    _prefs = _prefs ??= await SharedPreferences.getInstance();
    _prefs?.remove(key);
  }

  static Future<Map<String, dynamic>?> getJSONDocumentFirebase(
      String collectionName, String documentName,
      {bool userLevel = true}) async {
    final db = FirebaseFirestore.instance;
    try {
      final snapshot = userLevel
          ? await db
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.displayName! +
                  FirebaseAuth.instance.currentUser!.uid)
              .collection(collectionName)
              .doc(documentName)
              .get()
          : await db.collection(collectionName).doc(documentName).get();
      if (snapshot.exists) {
        return snapshot.data();
      }
    } catch (e) {
      print('caaaaaaaaaaaaaaaaaaaaaaaaaaaant');
      print(e);
    }
    return null;
  }

  static Future<List<Map<String, dynamic>>?> getJSONCollectionFirebase(
      String collectionName,
      {bool userLevel = true}) async {
    final db = FirebaseFirestore.instance;
    try {
      final querySnapshot = userLevel
          ? await db
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.displayName! +
                  FirebaseAuth.instance.currentUser!.uid)
              .collection(collectionName)
              .get()
          : await db.collection(collectionName).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('caaaaaaaaaaaaaaaaaaaaaaaaaaaant');
      print(e);
    }
    return null;
  }

  static Future<void> saveJSONFireBase(
      String collectionName, Map<String, dynamic> json,
      {String? docName}) async {
    final db = FirebaseFirestore.instance;
    try {
      await db
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.displayName! +
              FirebaseAuth.instance.currentUser!.uid)
          .collection(collectionName)
          .doc(docName ?? DateTime.now().toString())
          .set(json, SetOptions(merge: true))
          .timeout(
            const Duration(seconds: 5),
          );
    } catch (e) {
      print('Firestore Save Failed: ${e.toString()}');
    }
  }

  // static void autoSaveLocally(Map<String, dynamic> json) {
  // Timer.periodic(
  //   Duration(seconds: 30),
  //   (timer) {
  //     if (_workoutStarted) {
  //       DataStorage.saveJSONLocally(toJson());
  //     }
  //   },
  // );
  // }
}
