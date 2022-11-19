
import 'package:clean_architecture/core/strings/messages.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failure.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_posts.dart';
import '../../../domain/usecases/uapdate_posts.dart';

part 'add_update_delete_posts_event.dart';

part 'add_update_delete_posts_state.dart';

class AddUpdateDeletePostsBloc extends Bloc<AddUpdateDeletePostsEvent, AddUpdateDeletePostsState> {

  static AddUpdateDeletePostsBloc get(context)=>BlocProvider.of(context);

  final AddPostUseCase addPost;

  final UpdatePostUseCase updatePost;

  final DeletePostsUseCase deletePost;

  AddUpdateDeletePostsBloc(
      {required this.addPost, required this.updatePost, required this.deletePost})
      : super(AddUpdateDeletePostsInitial()) {
    on<AddUpdateDeletePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is EditPostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddUpdateDeleteState());
        final failureOrDoneMessage = await deletePost(event.postId);
        // failureOrDoneMessage.fold(
        //         (failure) =>emit(ErrorAddUpdateDeletePosts(message: mapOfFailureMessage(failure)))  ,
        //         (_) => emit(const MessageAddUpdateDeletePosts(message: DELETE_SUCCESS_MESSAGE))
        // );
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddUpdateDeletePostsState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> failure, message) {
    return failure.fold(
            (failure) => ErrorAddUpdateDeleteState(message: mapOfFailureMessage(failure)),
            (_) => MessageAddUpdateDeleteState(message: message)
    );
  }

  String mapOfFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailures:
        return SERVER_FUILURE_MESSAGE;
      case OffLineFailure:
        return OFFLINE_FUILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
