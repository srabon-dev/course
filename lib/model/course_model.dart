import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String? courseName;
  String? image;
  String? id;
  List<Video>? video;

  CourseModel({
    this.courseName,
    this.image,
    this.video,
    this.id
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    courseName: json["course-name"],
    image: json["image"],
    id: json["id"],
    video: json["video"] == null ? [] : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "course-name": courseName,
    "image": image,
    "id": id,
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x.toJson())),
  };
}

class Video {
  String? title;
  String? url;
  String? id;

  Video({
    this.title,
    this.url,
    this.id
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"],
    url: json["url"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "id": id,
  };
}
