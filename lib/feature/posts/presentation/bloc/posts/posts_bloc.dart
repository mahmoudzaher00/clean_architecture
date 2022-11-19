
import 'package:clean_architecture/core/error/failures.dart';
import 'package:clean_architecture/core/strings/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  static PostsBloc get(context)=>BlocProvider.of(context);
  final GetAllPostsUseCase getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts();
        emit(_mapFailureOrPostState(failureOrPosts));

        // final posts = await getAllPosts.call();
        // failureOrPosts.fold(
        //   (failure) {
        //     emit(ErrorPostsState(message: mapOfFailureMessage(failure)));
        //   },
        //   (posts) {
        //     emit(LoadedPostState(posts: posts));
        //   },
        // );
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPosts.call();
        emit(_mapFailureOrPostState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostState(Either<Failure, List<Post>> either){
    return either.fold(
            (failure) => ErrorPostsState(message: mapOfFailureMessage(failure)),
            (posts) => LoadedPostState(posts: posts));


  }

  String mapOfFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailures:
        return SERVER_FUILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FUILURE_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FUILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
