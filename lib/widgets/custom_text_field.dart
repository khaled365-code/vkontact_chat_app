
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {


  final  controller;
  final String hintText;
  final IconData icon;

   CustomTextField({super.key, required this.hintText,required this.controller, required this.icon});
  @override
  Widget build(BuildContext context)
  {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required ';
        }
        return null;
      },
      style: TextStyle(color: Colors.black, fontSize: 18),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(.5),
            fontSize: 18,
          ),
          fillColor: Colors.grey[100],
          filled: true,
          suffixIcon: Icon(
            icon,
            color: Colors.black,
            size: 25,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ))
      ),
    );


  }
}
