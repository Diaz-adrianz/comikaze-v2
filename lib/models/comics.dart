class ComicsModel {
  List<Comic>? results;

  ComicsModel({required this.results});

  ComicsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Comic>[];
      json['results'].forEach((v) {
        results!.add(Comic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comic {
  String? title;
  String? thumb;
  String? type;
  String? endpoint;
  String? updatedOn;

  Comic({this.title, this.thumb, this.type, this.endpoint, this.updatedOn});

  Comic.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    type = json['type'];
    endpoint = json['endpoint'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['type'] = this.type;
    data['endpoint'] = this.endpoint;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}
