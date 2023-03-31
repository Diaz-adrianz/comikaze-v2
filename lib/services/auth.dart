import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SERVICES & MODELS
import 'package:mobile/models/auth.dart';
import 'package:mobile/services/dio.dart';

// VIEWS
import 'package:mobile/views/login.dart';

class AuthCall extends Apicall {
  final model = MdlAuth;

  AuthCall(super.ctx, super._path, super._body, super._withToast);

  Future logout() async {
    Response res = await dio.post(path, data: body);
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Bye bye'),
      backgroundColor: Colors.green,
    ));

    // BACKEND PROCESS
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('code');
    prefs.remove('nama');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);

    return true;
  }

  Future login() async {
    Response res = await dio.post(path, data: body);
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Hello'),
    //   backgroundColor: Colors.green,
    // ));

    // BACKEND PROCESS
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('code', res.data['code']);
    prefs.setString('nama', res.data['name']);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));

    return true;
  }
}

Future<String?> CheckLogin(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var code = prefs.getString('code');

  if (code == null) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  return code;
}
