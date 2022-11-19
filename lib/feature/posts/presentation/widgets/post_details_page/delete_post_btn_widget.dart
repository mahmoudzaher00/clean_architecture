import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/snackbar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import '../../pages/post_page.dart';
import 'delete_dialog_widget.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int? postId;
  const DeletePostBtnWidget({Key? key, this.postId}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: ()=>deleteDialog(context,postId),
      style:  ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red)
      ),
      icon: const Icon(Icons.delete),
      label: const Text('Edit'),

    );
  }
  void deleteDialog(context,postId){
    showDialog(context: context, builder: (context){
      return  BlocConsumer<AddUpdateDeletePostsBloc, AddUpdateDeletePostsState>(
        listener: (context, state) {
          if(state is MessageAddUpdateDeleteState){
            SnackBarMessage().showSuccessSnackBar(context:context, message:state.message);
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_)=>const PostPage()), (route) => false);
          }else if(state is ErrorAddUpdateDeleteState){
            Navigator.pop(context);
            SnackBarMessage().showErrorSnackBar(context, state.message);

          }
        },
        builder: (context, state) {
          if(state is LoadingAddUpdateDeleteState){
            return const AlertDialog(title: LoadingWidget());
          }
          return DeleteDialogWidget(id:postId);
        },
      );

    });
  }
}
