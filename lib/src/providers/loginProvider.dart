import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/loginModel.dart';

class LoginProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool btnLoading = false, secure = true;

  toogleSecure() {
    secure = !secure;
    notifyListeners();
  }

  toogleLoading() {
    btnLoading = !btnLoading;
    notifyListeners();
  }

  String? emailValidator(email) {
    String emailPattern = r'(.+\@.+\..+)';
    if (email == null || email.isEmpty || !RegExp(emailPattern).hasMatch(email)) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? passwordValidator(password) {
                  if (password == null || password.isEmpty) {
                    return 'Please enter valid password';
                  }
                  return null;
                }

  Future<Map<String, dynamic>> login() async {
    toogleLoading();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://dev2.deliveryapp.com/api/user/authenticate'));
    request.body = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
      "device_name": "mobile",
      "device_token": "${DateTime.now().millisecond}",
      "device_os": Platform.operatingSystem,
      "device_details": "[]"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      LoginModel loginModel = LoginModel.fromJson(data);
      // or data['token']
      toogleLoading();
      await savePrefrences();
      return {"success": true, "token": loginModel.token};
    } else {
      toogleLoading();
      return {"success": false, "msg": data['message']};
    }
  }

  savePrefrences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }
}
