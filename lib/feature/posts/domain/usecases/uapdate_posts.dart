import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post.dart';
import 'package:clean_architecture/feature/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUseCase{
  final PostsRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Either<Failure,Unit>> call(Post post)async{
    return await repository.updatePosts(post);
  }
}