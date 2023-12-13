import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdkey="userkey";
  static String userNamekey="usernamekey";
  static String userEmailkey="useremailkey";
  static String userPickey="userpickey";
  static String displaynameKey="userdisplayname";


  Future <bool> savedUserId(String getUserId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdkey, getUserId);
  }
  Future <bool> savedUserName(String getUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNamekey, getUserName);
  }
  Future <bool> savedUserEmail(String getUserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailkey, getUserEmail);
  }
  Future <bool> savedUserPic(String getUserPic) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPickey, getUserPic);
  }
  Future <bool> savedUserDisplayName(String getUserDisplayName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displaynameKey, getUserDisplayName);
  }
  Future <String?> getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdkey);
  }
  Future <String?> getUserName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNamekey);
  }
  Future <String?> getUserEmail() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailkey);
  }
  Future <String?> getUserPic() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPickey);
  }
  Future <String?> getUserDisplayName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displaynameKey);
  }
}
