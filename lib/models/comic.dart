import './chapters.dart';

class ComicModel {
  String? title;
  String? type;
  String? age;
  String? author;
  String? status;
  String? mangaEndpoint;
  String? thumb;
  List<String>? genreList;
  String? synopsis;
  List<ChaptersModel>? chapter;

  ComicModel(
      {this.title,
      this.type,
      this.age,
      this.author,
      this.status,
      this.mangaEndpoint,
      this.thumb,
      this.genreList,
      this.synopsis,
      this.chapter});

  ComicModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    age = json['age'];
    author = json['author'];
    status = json['status'];
    mangaEndpoint = json['manga_endpoint'];
    thumb = json['thumb'];
    genreList = json['genre_list'].cast<String>();
    synopsis = json['synopsis'];
    if (json['chapter'] != null) {
      chapter = <ChaptersModel>[];
      json['chapter'].forEach((v) {
        chapter!.add(ChaptersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['age'] = age;
    data['author'] = author;
    data['status'] = status;
    data['manga_endpoint'] = mangaEndpoint;
    data['thumb'] = thumb;
    data['genre_list'] = genreList;
    data['synopsis'] = synopsis;
    if (chapter != null) {
      data['chapter'] = chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
