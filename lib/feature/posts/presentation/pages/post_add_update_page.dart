import 'package:clean_architecture/core/util/snackbar_message.dart';
import 'package:clean_architecture/core/widgets/loading_widget.dart';
import 'package:clean_architecture/feature/posts/domain/entities/post.dart';
import 'package:clean_architecture/feature/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:clean_architecture/feature/posts/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/post_add_update_page/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;

  const PostAddUpdatePage({Key? key, this.post, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
          isUpdate ? "Edit Post" : "Add Post"
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<AddUpdateDeletePostsBloc, AddUpdateDeletePostsState>(
          listener: (context, state) {
            if(state is MessageAddUpdateDeleteState){

              SnackBarMessage().showSuccessSnackBar(context:context, message: state.message);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context)=>const PostPage()),
                      (route) => false);
            }
            else if(state is ErrorAddUpdateDeleteState){
             SnackBarMessage().showErrorSnackBar(context, state.message);
            }

          },
          builder: (context, state) {
            if(state is LoadingAddUpdateDeleteState) {
              return const LoadingWidget();
            }
              return FormWidget(
                isUpdatePost:isUpdate,post:isUpdate?post:null,
              );


          }
        ),
      ),
    );
  }
}
