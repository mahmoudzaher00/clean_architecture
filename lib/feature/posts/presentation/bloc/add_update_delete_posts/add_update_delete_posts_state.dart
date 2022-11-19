part of 'add_update_delete_posts_bloc.dart';

abstract class AddUpdateDeletePostsState extends Equatable {
  const AddUpdateDeletePostsState();
}

class AddUpdateDeletePostsInitial extends AddUpdateDeletePostsState {
  @override
  List<Object> get props => [];
}

class LoadingAddUpdateDeleteState extends AddUpdateDeletePostsState {
  @override
  List<Object> get props => [];
}

class MessageAddUpdateDeleteState extends AddUpdateDeletePostsState {
  final String message;

  const MessageAddUpdateDeleteState({required this.message});
  @override
  List<Object> get props => [];
}

class ErrorAddUpdateDeleteState extends AddUpdateDeletePostsState {
  final String message;

  const ErrorAddUpdateDeleteState({required this.message});
  @override
  List<Object> get props => [message];
}
