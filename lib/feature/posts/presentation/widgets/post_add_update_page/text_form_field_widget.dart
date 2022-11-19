import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
   const TextFormFieldWidget({
    Key? key,
    required  this.textEditingController, this.hintText, this.validatorText, this.minLines, this.maxLines,
  }) ;

  final TextEditingController textEditingController;
  final String? hintText;
  final String? validatorText;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: (value){
        if(value!.isEmpty){
          return validatorText;
        }
        return null;
      },
      decoration:  InputDecoration(
        hintText: hintText!,
      ),
      maxLines: maxLines??1,
      minLines: minLines??1,


    );
  }
}
