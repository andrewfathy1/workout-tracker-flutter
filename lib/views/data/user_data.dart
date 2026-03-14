import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  // late String? _userName = "";
  late int? _userAge;
  late String? _userGoal;
  static SharedPreferences? _prefs;

  // String? get userName => _userName;
  int? get userAge => _userAge;
  String? get userGoal => _userGoal;

  UserData() {
    getUserData();
  }

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveData(
      {required String name, required int age, required String goal}) async {
    final prefs = await _getPrefs();
    // await prefs.setString('username', name);
    await prefs.setInt('age', age);
    await prefs.setString('userGoal', goal);
    await getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await _getPrefs();
    // _userName = prefs.getString('username');
    _userAge = prefs.getInt('age');
    _userGoal = prefs.getString('userGoal');
    notifyListeners();
  }

  // Future<bool> checkUserExists() async {
  //   final prefs = await _getPrefs();
  //   if (prefs.containsKey('username')) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  Future<void> deleteUserData() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }
}
