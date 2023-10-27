import 'package:flutter/material.dart';

class CustomSendChatField extends StatelessWidget {


  final controller;
  final int? maxLines;
  final String? hintText;
  void Function(String)? onSubmitted;

   CustomSendChatField({super.key,required this.controller, this.maxLines,this.hintText,this.onSubmitted});

  @override
  Widget build(BuildContext context)
  {

    return Container(
      width: 285,
      height: 60,
      child: TextField(
        controller: controller,
        maxLines: 30,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xff737373),fontWeight: FontWeight.bold),
            fillColor: Colors.grey[100],
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20))),
      ),
    );

  }
}
