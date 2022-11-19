import 'package:clean_architecture/feature/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class PostsRepository{
 Future<Either<Failure,List<Post>>> getAllPosts ();
 Future<Either<Failure,Unit>> deletePosts (int id);
 Future<Either<Failure,Unit>>  updatePosts (Post post);
 Future<Either<Failure,Unit>>  addPosts (Post post);

}
//<Failure,List<post>