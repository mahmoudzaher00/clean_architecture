import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';
import '../../pages/post_details_page.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      separatorBuilder: (context,index){
        return const Divider(thickness: 1,);
        },
      itemBuilder: (context,index){
        return ListTile(
          leading: Text(posts[index].id.toString()),
          title: Text(
            posts[index].title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: const TextStyle(
                fontSize: 16,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PostDetailsPage(post: posts[index])));
          },
        );
      },

    );
  }
}
