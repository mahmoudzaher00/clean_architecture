import 'package:clean_architecture/core/error/exception.dart';
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/feature/posts/data/models/post_model.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository{

  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;



  PostsRepositoryImpl({required this.remoteDataSource, required this.localDataSource,required this.networkInfo});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async{
    if(await networkInfo.isConnected){
      try {
         final remoteDataPosts = await remoteDataSource.getAllPost();
         localDataSource.cachePosts(remoteDataPosts);
        return Right(remoteDataPosts);
      }on ServerException{
        return Left(ServerFailures());
      }
    }else{
      try{
        final localDataPosts = await localDataSource.getCachedPosts();
        return Right(localDataPosts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPosts(Post post) async{
    final PostModel postModel=PostModel(body: post.body, title: post.title );
    return await getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePosts(int postId) async{
    return await getMessage(() => remoteDataSource.deletePost(postId));
  }



  @override
  Future<Either<Failure, Unit>> updatePosts(Post post) async{
    final PostModel postModel=PostModel(id: post.id!, body: post.body, title: post.title);
    return await getMessage(() => remoteDataSource.updatePost(postModel));

  }
  Future<Either<Failure, Unit>> getMessage( DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost  )async{
  if(await networkInfo.isConnected){
    try{
      await deleteOrUpdateOrAddPost();
      return const Right(unit);
    }on ServerException{
      return Left(ServerFailures());
    }
  }else{
    return Left(OffLineFailure());
  }
}
}