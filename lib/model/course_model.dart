// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String? courseName;
  String? image;
  List<Video>? video;

  CourseModel({
    this.courseName,
    this.image,
    this.video,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    courseName: json["course-name"],
    image: json["image"],
    video: json["video"] == null ? [] : List<Video>.from(json["video"]!.map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "course-name": courseName,
    "image": image,
    "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x.toJson())),
  };
}

class Video {
  String? title;
  String? url;

  Video({
    this.title,
    this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    title: json["title"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
  };
}
