import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';
import '../widgets/post_details_page/post_details_widget.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Post Details'),
    );
  }
  Widget buildBody(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: PostDetailsWidget(post:post),
      ),
    );
  }

}
