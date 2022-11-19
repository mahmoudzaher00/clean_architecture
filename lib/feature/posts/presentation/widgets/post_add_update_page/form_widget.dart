import 'package:clean_architecture/feature/posts/presentation/bloc/add_update_delete_posts/add_update_delete_posts_bloc.dart';
import 'package:clean_architecture/feature/posts/presentation/widgets/post_add_update_page/form_submit_btn_widget.dart';
import 'package:clean_architecture/feature/posts/presentation/widgets/post_add_update_page/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/post.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({Key? key, required this.isUpdatePost,  this.post}) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _bodyController=TextEditingController();
  @override
  void initState(){
    if(widget.isUpdatePost){
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormFieldWidget(
            textEditingController: _titleController,
            hintText: "Title",
            validatorText: "Title can't be empty",
          ),
          const SizedBox(height: 10,),
          TextFormFieldWidget(
            textEditingController: _bodyController,
            hintText: "Body",
            validatorText: "Body can't be empty",
            minLines: 6,
            maxLines: 6,
          ),
          const SizedBox(height: 20,),
          FormSubmitBtnWidget(
            isUpdate: widget.isUpdatePost,
            onPressed: validateFormThenUpdateOrAddPost,
          )
        ],
      ),

    );
  }



  void validateFormThenUpdateOrAddPost(){
    if(_formKey.currentState!.validate()){
      final post=Post(id: widget.isUpdatePost?widget.post!.id:null, title: _titleController.text, body: _bodyController.text);

      if(widget.isUpdatePost){
        BlocProvider.of<AddUpdateDeletePostsBloc>(context).add(EditPostEvent(post: post));
      }else{
        BlocProvider.of<AddUpdateDeletePostsBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }

}

