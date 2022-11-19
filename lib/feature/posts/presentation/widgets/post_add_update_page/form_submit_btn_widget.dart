import 'package:flutter/material.dart';

class FormSubmitBtnWidget extends StatelessWidget {
  // final VoidCallback? onPressed;
  final void Function()? onPressed;
  final bool? isUpdate;
  final String? textBtn;

  const FormSubmitBtnWidget({super.key, this.onPressed, this.isUpdate, this.textBtn});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed:onPressed,
      icon: Icon(isUpdate!?Icons.edit:Icons.add,size: 20,),
      label:  Text(isUpdate!?'Update':'Add'),

    );
  }
}