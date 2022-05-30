import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/main.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prueba Tecnica",
      //initialRoute: '/',
      home: Second(),
    );
  }
}

class Second extends StatefulWidget {
  Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  Future getCommentData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'comments'));

    var jsonData = jsonDecode(response.body);
    List<Comment> comments = [];

    for (var c in jsonData) {
      Comment comment = Comment((c['postId']).toString(), c['name'], c['body']);
      comments.add(comment);
    }
    print(comments.length);
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getCommentData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: listComments(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('error');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  List<Widget> listComments(data) {
    List<Widget> comments = [];
    for (var comment in data) {
      comments.add(Card(
        child: ListTile(
          leading: Text(comment.postId),
          title: Text(comment.name),
          subtitle: Text(comment.body),
        ),
      ));
    }
    return comments;
  }
}

class Comment {
  final String postId, name, body;
  Comment(this.postId, this.name, this.body);
}
