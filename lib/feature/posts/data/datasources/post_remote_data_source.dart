import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart'as http ;

abstract class PostRemoteDataSource  {
  Future<List<PostModel>>getAllPost();
  Future<Unit>deletePost(int id);
  Future<Unit>updatePost(PostModel postModel );
  Future<Unit>addPost(PostModel postModel);
}
const BASE_URL ="https://jsonplaceholder.typicode.com";
class PostRemoteDataSourceImpl implements PostRemoteDataSource{
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPost() async{
    final response = await client.get(
        Uri.parse("$BASE_URL/posts/"),
        headers: {
          "Content-Type" :"application/json"
        }
    );
    if(response.statusCode==200){
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModelResponse =decodedJson.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      return postModelResponse;
    }else{
      throw ServerException();
    }

  }

  @override
  Future<Unit> addPost(PostModel postModel) async{
    final body = {
      'title' : postModel.title,
      'body' : postModel.body
    };

    final response = await client.post(
        Uri.parse("$BASE_URL/posts/"),
        body: body
    );
     if(response.statusCode==201){
       return Future.value(unit);

     }else{
       throw ServerException();
     }

  }

  @override
  Future<Unit> deletePost(int postId) async{
    final response = await client.delete(
        Uri.parse("$BASE_URL/posts/${postId.toString()}"),
        headers: {
          "Content-Type" :"application/json"
        }
    );
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async{
    final postId=postModel.id.toString();
    final body = {
      'title' : postModel.title,
      'body' : postModel.body
    };

    final response = await client.patch(
      Uri.parse("$BASE_URL/posts/$postId"),
        body: body,
        
    );
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
  
}