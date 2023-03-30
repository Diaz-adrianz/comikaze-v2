import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import '../views/login.dart';

class MyException implements Exception {
  final String message;

  MyException(this.message);

  @override
  String toString() => 'MyException: $message';
}

class Apicall {
  final String baseUri =
      'https://komiku-api-2-6f9pvug2y-diaz-adrianz.vercel.app/';
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://komiku-api-2.vercel.app/api/',
    validateStatus: (status) => true,
  ));
  String path = '';
  Object? body = {};
  bool withToast = true;
  dynamic context;
  String msg = '';

  // ignore: no_leading_underscores_for_local_identifiers
  Apicall(ctx, String _path, Object _body, bool _withToast) {
    path = _path;
    body = _body;
    withToast = _withToast;
    context = ctx;

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future get(Future func) async {
    try {
      return await func;
    } catch (e) {
      if (e is MyException) {
        if (e.message == 'Account is inactive') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.redAccent,
          ));
        }
      } else {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Application Error'),
          backgroundColor: Colors.redAccent,
        ));
      }

      return true;
    }
  }

  Future post(Future func) async {
    try {
      return await func;
    } catch (e) {
      if (e is MyException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
          backgroundColor: Colors.redAccent,
        ));
      } else {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Application Error'),
          backgroundColor: Colors.redAccent,
        ));
      }
    }
  }
}
