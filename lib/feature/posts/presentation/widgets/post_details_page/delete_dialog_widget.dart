import 'package:clean_architecture/feature/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int id;
  const DeleteDialogWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure ?'),
      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('No')),
        TextButton(onPressed: (){
          BlocProvider.of<AddUpdateDeletePostsBloc>(context).add(DeletePostEvent(postId: id));
        }, child: const Text('Yes')),
      ],

    );
  }
}
