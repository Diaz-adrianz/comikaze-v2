class GenresModel {
  List<Genre>? results;

  GenresModel({this.results});

  GenresModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Genre>[];
      json['results'].forEach((v) {
        results!.add(Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Genre {
  String? genreName;
  String? endpoint;

  Genre({this.genreName, this.endpoint});

  Genre.fromJson(Map<String, dynamic> json) {
    genreName = json['genre_name'];
    endpoint = json['endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genre_name'] = genreName;
    data['endpoint'] = endpoint;
    return data;
  }
}
