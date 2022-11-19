import 'package:clean_architecture/feature/posts/domain/entities/post.dart';

class PostModel extends Post{
  const PostModel({ int? id,required String body,required String title}):
        super(id: id,title: title,body: body);

  factory PostModel.fromJson (Map<String,dynamic>json){
    return PostModel(id: json['id'],title: json['title'],body: json['body']);
  }
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'title' :  title,
      'body':  body
    };
  }

}