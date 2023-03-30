class ChapterModel {
  String? chapterEndpoint;
  String? chapterPrevEndpoint;
  String? chapterNextEndpoint;
  String? chapterName;
  String? title;
  int? chapterPages;
  List<ChapterImage>? chapterImage;

  ChapterModel(
      {this.chapterEndpoint,
      this.chapterPrevEndpoint,
      this.chapterNextEndpoint,
      this.chapterName,
      this.title,
      this.chapterPages,
      this.chapterImage});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    chapterEndpoint = json['chapter_endpoint'];
    chapterPrevEndpoint = json['chapter_prev_endpoint'];
    chapterNextEndpoint = json['chapter_next_endpoint'];
    chapterName = json['chapter_name'];
    title = json['title'];
    chapterPages = json['chapter_pages'];
    if (json['chapter_image'] != null) {
      chapterImage = <ChapterImage>[];
      json['chapter_image'].forEach((v) {
        chapterImage!.add(ChapterImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_endpoint'] = chapterEndpoint;
    data['chapter_prev_endpoint'] = chapterPrevEndpoint;
    data['chapter_next_endpoint'] = chapterNextEndpoint;
    data['chapter_name'] = chapterName;
    data['title'] = title;
    data['chapter_pages'] = chapterPages;
    if (chapterImage != null) {
      data['chapter_image'] = chapterImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterImage {
  String? chapterImageLink;
  int? imageNumber;

  ChapterImage({this.chapterImageLink, this.imageNumber});

  ChapterImage.fromJson(Map<String, dynamic> json) {
    chapterImageLink = json['chapter_image_link'];
    imageNumber = json['image_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chapter_image_link'] = chapterImageLink;
    data['image_number'] = imageNumber;
    return data;
  }
}
