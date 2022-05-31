// To parse this JSON data, do
//
//     final postRequest = postRequestFromJson(jsonString);

import 'dart:convert';

PostRequest postRequestFromJson(String str) =>
    PostRequest.fromJson(json.decode(str));

String postRequestToJson(PostRequest data) => json.encode(data.toJson());

class PostRequest {
  PostRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  }) {
    // TODO: implement
    throw UnimplementedError();
  }

  int id;
  String title;
  String body;
  String userId;

  factory PostRequest.fromJson(Map<String, dynamic> json) => PostRequest(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
      };
}
