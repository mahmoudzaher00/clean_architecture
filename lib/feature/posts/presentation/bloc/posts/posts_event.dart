part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
class GetAllPostsEvent extends PostsEvent{}

class RefreshPostsEvent extends PostsEvent{}