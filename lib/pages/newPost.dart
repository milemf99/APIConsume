import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/post.dart';

class Third extends StatefulWidget {
  Third({Key? key}) : super(key: key);

  @override
  _ThirdState createState() => _ThirdState();
}

Future<PostRequest?> submitPost(
    String title, String body, String userId) async {
  var response = await http.post(
      Uri.https('jsonplaceholder.typicode.com', '/posts'),
      body: {"title": title, "body": body, "userId": userId});
  var data = response.body;
  print(data);

  if (response.statusCode == 200) {
    String responseString = response.body;
    postRequestFromJson(responseString);
  } else
    return null;
}

void dataModelFromJson(String responseString) {}

class _ThirdState extends State<Third> {
  late PostRequest _PostRequest;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController useridController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New Post"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Title'),
                controller: titleController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Description'),
                controller: descriptionController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'UserId'),
                controller: useridController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String userId = useridController.text;
                    String title = titleController.text;
                    String body = descriptionController.text;

                    PostRequest? post = await submitPost(title, body, userId);
                    setState(() {
                      _PostRequest = post!;
                    });
                  },
                  child: Text("GUARDAR"))
            ],
          ),
        ));
  }
}
