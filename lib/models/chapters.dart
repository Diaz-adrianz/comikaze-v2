class ChaptersModel {
  String? chapterTitle;
  String? chapterEndpoint;

  ChaptersModel({chapterTitle, chapterEndpoint});

  ChaptersModel.fromJson(Map<String, dynamic> json) {
    chapterTitle = json['chapter_title'];
    chapterEndpoint = json['chapter_endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_title'] = chapterTitle;
    data['chapter_endpoint'] = chapterEndpoint;
    return data;
  }
}
