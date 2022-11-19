part of 'add_update_delete_posts_bloc.dart';

abstract class AddUpdateDeletePostsEvent extends Equatable {
  const AddUpdateDeletePostsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddPostEvent extends AddUpdateDeletePostsEvent{
  final Post post;
  const AddPostEvent({required this.post});
  @override
  // TODO: implement props
  List<Object?> get props => [post];

}

class DeletePostEvent extends AddUpdateDeletePostsEvent{
  final int postId;

  const DeletePostEvent({required this.postId});
  @override
  // TODO: implement props
  List<Object?> get props => [postId];

}

class EditPostEvent extends AddUpdateDeletePostsEvent{
  final Post post;

  const EditPostEvent({required this.post});
  @override
  // TODO: implement props
  List<Object?> get props => [post];
}
