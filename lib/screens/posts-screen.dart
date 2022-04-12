import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_app/dio.dart';
import 'package:login_app/models/post.dart';
import 'package:login_app/provider/auth.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Future<List<Post>> getPosts() async
  {
    var token = await Auth().getToken();

    print(token);
     final response = await dio().get(
         'user/posts',
          options: Options(
            headers:{
              // 'auth':true
              'Authorization':'Bearer $token'
            }
          )
     );

     List posts = json.decode(response.toString());

     return posts.map((post) => Post.fromJson(post)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts'
        ),
      ),
      body:Center(
        child: FutureBuilder<List<Post>>(
            future: getPosts(),
            builder: (context,snapshot){
              if(snapshot.hasData)
              {
                 return ListView.builder(
                     itemCount: snapshot.data!.length,

                     itemBuilder: (context,index){
                       var item = snapshot.data![index];

                       return ListTile(
                         title: Text(item.title ?? ''),
                       );
                     }
                 );
              }else if(snapshot.hasError){
                print(snapshot.error);
                return const Text('Failed to Load user post');
              }
              return const CircularProgressIndicator();
            }
        )
      ),
    );
  }
}
