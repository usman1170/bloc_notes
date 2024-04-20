// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zoom/data/models/comment_model.dart';
import 'package:zoom/data/models/image_model.dart';
import 'package:zoom/data/models/post_model.dart';
import 'package:zoom/data/models/user_model.dart';

class Apis {
  List<PostsModel> postList = [];
  List<UserModel> userList = [];
  List<CommentModel> commentList = [];
  List<ImageModel> imageList = [];

  final posts = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  final comments = Uri.parse("https://jsonplaceholder.typicode.com/comments");
  final imgs = Uri.parse("https://jsonplaceholder.typicode.com/photos");
  final users = Uri.parse("https://jsonplaceholder.typicode.com/users");
  Future<List<PostsModel>> getPosts() async {
    try {
      final response = await http.get(posts);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        postList.cast();
        for (Map<String, dynamic> i in data) {
          postList.add(PostsModel.fromJson(i));
        }

        return postList;
      } else {
        return postList;
      }
    } catch (e) {
      return postList;
    }
  }

  // comments function
  Future<List<CommentModel>> getcomments() async {
    try {
      final response = await http.get(comments);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        postList.cast();
        for (Map<String, dynamic> i in data) {
          commentList.add(CommentModel.fromJson(i));
        }

        return commentList;
      } else {
        return commentList;
      }
    } catch (e) {
      return commentList;
    }
  }

  //photos func
  Future<List<ImageModel>> getPhotos() async {
    try {
      final response = await http.get(imgs);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        postList.cast();
        for (Map<String, dynamic> i in data) {
          imageList.add(ImageModel.fromJson(i));
        }

        return imageList;
      } else {
        return imageList;
      }
    } catch (e) {
      return imageList;
    }
  }

  //users
  Future<List<UserModel>> getusers() async {
    try {
      final response = await http.get(posts);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        postList.cast();
        for (Map<String, dynamic> i in data) {
          userList.add(UserModel.fromJson(i));
        }

        return userList;
      } else {
        return userList;
      }
    } catch (e) {
      return userList;
    }
  }
}
