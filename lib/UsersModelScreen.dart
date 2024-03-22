import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/UsersModel.dart';

class UsersModelScreen extends StatefulWidget {
  const UsersModelScreen({super.key});

  @override
  State<UsersModelScreen> createState() => _UsersModelScreenState();
}

class _UsersModelScreenState extends State<UsersModelScreen> {

  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUserApi () async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userList.clear();
      for (Map i in data) {
        userList.add(UsersModel.fromJson(i));
      }
      return userList;

    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text('RESTFull API - Users Screen', style: TextStyle(
              color: Colors.white
          ),),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getUserApi(),
                    builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {

                      if (!snapshot.hasData) {
                        return const Center(child: Text('Loading...'));

                      } else {
                        return ListView.builder(
                            itemCount: userList.length,
                            itemBuilder: (context, index){

                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Serial Number:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          Text(
                                            userList[index].id.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Name:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          Text(
                                            userList[index].name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Email:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          Text(
                                            userList[index].email,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Username:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          Text(
                                            userList[index].username,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Address:',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                          Text(
                                            '${userList[index].address.city} - ${userList[index].address.street}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            });
                      }

                    }
                ),
            )
          ],
        ),
      ),
    );
  }
}
