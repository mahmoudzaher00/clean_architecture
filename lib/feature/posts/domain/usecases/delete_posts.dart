import 'package:clean_architecture/feature/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class DeletePostsUseCase {
  final PostsRepository repository;


  DeletePostsUseCase(this.repository);

  Future<Either<Failure,Unit>> call(int postId)async{
    return await repository.deletePosts(postId);
  }
}