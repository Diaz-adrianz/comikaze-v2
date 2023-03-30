import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/comic.dart';
import 'package:mobile/models/comics.dart';
import 'package:mobile/models/genres.dart';
import 'package:mobile/services/auth.dart';
import 'package:mobile/views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SERVICES & MODELS
import 'package:mobile/models/auth.dart';
import 'package:mobile/services/dio.dart';

// VIEWS
import 'package:mobile/views/login.dart';

import '../models/chapter.dart';

class ComicCall extends Apicall {
  final model = MdlAuth;

  ComicCall(super.ctx, super._path, super._body, super._withToast);

  Future<List<Comic>?> getComics() async {
    String? code = await CheckLogin(context);

    Response res =
        await dio.get(path, options: Options(headers: {'code': code}));
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    var comics = ComicsModel.fromJson(res.data);
    return comics.results;
  }

  Future<List<Genre>?> getGenres() async {
    Response res = await dio.get(path);
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    var genres = GenresModel.fromJson(res.data);
    return genres.results;
  }

  Future<ComicModel?> getDetail() async {
    String? code = await CheckLogin(context);

    Response res =
        await dio.get(path, options: Options(headers: {'code': code}));
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    return ComicModel.fromJson(res.data);
  }

  Future<ChapterModel?> getChapters() async {
    String? code = await CheckLogin(context);

    Response res =
        await dio.get(path, options: Options(headers: {'code': code}));
    int? status = res.statusCode;

    if (status != 200) {
      throw MyException(res.data['message']);
    }

    return ChapterModel.fromJson(res.data);
  }
}
