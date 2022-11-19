import 'package:clean_architecture/feature/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture/feature/posts/presentation/pages/post_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/post_page/message_display_widget.dart';
import '../widgets/post_page/posts_list_widget.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(context),
    );
  }

  AppBar buildAppBar() => AppBar(title: const Text("Posts"),);

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return const LoadingWidget();
          } else if (state is LoadedPostState) {
            return RefreshIndicator(
               onRefresh:()=>buildOnRefresh(context) ,
               child :  PostListWidget(posts: state.posts));
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void>  buildOnRefresh(BuildContext context) async {
  print('>>>>>>>>>Refresh..........');
    PostsBloc.get(context).add(RefreshPostsEvent());

    // BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  Widget buildFloatingActionButton(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const  PostAddUpdatePage(isUpdate: false,)));
      },
      child: const Icon(Icons.add),
    );
  }

}
