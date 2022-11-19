import 'package:clean_architecture/feature/posts/presentation/widgets/post_details_page/update_post_btn_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import 'delete_post_btn_widget.dart';

class PostDetailsWidget extends StatelessWidget {
  final Post post;
  const PostDetailsWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(post.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          const Divider(height: 50,),
          Text(post.body,style: const TextStyle(fontSize: 16),),
          const Divider(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post:post),
              DeletePostBtnWidget(postId:post.id!)
            ],
          )

        ],
      ),
    );
  }


  }


