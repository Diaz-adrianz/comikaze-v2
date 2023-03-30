import 'package:flutter/material.dart';

class LocalSaveModel {
  String? title;
  String? subtitle;
  String? endpoint;
  String? thumb;
  String? updated_on;

  LocalSaveModel({title, subtitle, endpoint, thumb, updated_on});

  LocalSaveModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    endpoint = json['endpoint'];
    thumb = json['thumb'];
    updated_on = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['title'] = title;
    json['subtitle'] = subtitle;
    json['endpoint'] = endpoint;
    json['thumb'] = thumb;
    json['updated_on'] = updated_on;
    return json;
  }
}
