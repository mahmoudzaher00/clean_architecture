import 'dart:convert';

import 'package:clean_architecture/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/post_model.dart';

abstract class PostLocalDataSource  {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModel);
}
class PostLocalDataSourceImpl implements PostLocalDataSource{
  final SharedPreferences sharedPreferences;

  PostLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelToJson=postModels.map<Map<String,dynamic>>((postModel) => postModel.toJson()).toList();
    sharedPreferences.setString('CACHED_POSTS', json.encode(postModelToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString('CACHED_POSTS');
    if(jsonString !=null){
      List jsonDecodeData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = jsonDecodeData.map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel)).toList();
      //في الحاله ان ال method future مش هقدر ارجع ع طول jsonToPostModels
      // return jsonToPostModels;
      // بما ان دا future لازم ارحع (jsonToPostModels)future.value
      return Future.value(jsonToPostModels);
    }else{
      throw  EmptyCacheException();
    }

  }
  
}