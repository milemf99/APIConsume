import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/pages/comments.dart';
import 'package:project/pages/newPost.dart';

//import 'package:project/pages/comments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prueba Tecnica",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  Future getPostData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

    var jsonData = jsonDecode(response.body);
    List<Post> posts = [];

    for (var p in jsonData) {
      Post post = Post((p['id']), (p['userId']), p['title'], p['body']);
      posts.add(post);
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: getPostData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: listPosts(snapshot.data),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('error');
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Third()),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  List<Widget> listPosts(data) {
    List<Widget> posts = [];
    for (var post in data) {
      posts.add(InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Second(postId: post.id)),
          );
        },
        child: Card(
          child: ListTile(
            leading: Text(
              post.userId.toString(),
              style: TextStyle(fontSize: 30),
            ),
            title: Text(
              post.title,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(post.body),
          ),
          color: Colors.grey[350],
        ),
      ));
    }
    return posts;
  }
}

class Post {
  final String title, body;
  final int id, userId;

  Post(this.id, this.userId, this.title, this.body);
}
