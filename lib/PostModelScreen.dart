import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/Models/PostsModel.dart';
import 'package:http/http.dart' as http;

class PostModelScreen extends StatefulWidget {
  const PostModelScreen({super.key});

  @override
  State<PostModelScreen> createState() => _PostModelScreenState();
}

class _PostModelScreenState extends State<PostModelScreen> {

  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;

    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text('RESTFull API - Posts Screen', style: TextStyle(
            color: Colors.white
          ),),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('loading');
            
                  } else {
                    return ListView.builder(
                      itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Title:',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    postList[index].title.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    height: 2,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    postList[index].body.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        });
            
                  }
                }),
          )
        ],
      ),
    );
  }
}
