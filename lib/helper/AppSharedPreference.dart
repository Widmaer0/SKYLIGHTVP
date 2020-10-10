import 'dart:convert';
import 'package:flutter_skyplight/model/RegisterModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserModel.dart';

class AppSharedPreference {
  final String _userName = "_userName";
  final String _email = "_email";
  final String _userDetail = "_userDetail";
  final String _bankInfo = "_bankInfo";
  final String _profileInfo = "_profileInfo";
  final String isLogged = "isLogged";

  Future<bool> saveUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(_userName, userName);
  }

  Future<String> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(_userName);
  }
  Future<bool> saveEmail(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setString(_email, userName);
  }

  Future<String> getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(_email);
  }

  Future<bool> isLoggedIn(bool flag) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.setBool(isLogged, flag);
  }

  Future<bool> getIsLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(isLogged);
  }

  Future<bool> saveUser(String str) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map decodedata = json.decode(str);
    if (decodedata != null) {
      String user = jsonEncode(RegisterModel.fromJson(decodedata));
      return preferences.setString(_userDetail, user);
    }
  }

  Future<RegisterModel> getUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(preferences.getString(_userDetail));
    RegisterModel user = RegisterModel.fromJson(userMap);
    return user;
  }

  Future<bool> saveBankInfo(String str) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map decodedata = json.decode(str);
    if (decodedata != null) {
      String user = jsonEncode(RegisterBank.fromJson(decodedata));
      return preferences.setString(_bankInfo, user);
    }
  }

  Future<RegisterBank> getBankInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(preferences.getString(_bankInfo));
    RegisterBank bankDetail = RegisterBank.fromJson(userMap);
    return bankDetail;
  }

  Future<bool> saveProfileInfo(String str) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map decodedata = json.decode(str);
    if (decodedata != null) {
      String user = jsonEncode(RegisterPhoto.fromJson(decodedata));
      return preferences.setString(_profileInfo, user);
    }
  }

  Future<RegisterPhoto> getProfileInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(preferences.getString(_profileInfo));
    RegisterPhoto profileInfo = RegisterPhoto.fromJson(userMap);
    return profileInfo;
  }
}
