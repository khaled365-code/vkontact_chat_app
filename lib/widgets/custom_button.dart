import 'package:flutter/material.dart';






class Custombutton extends StatelessWidget
{

  final String text;
  Custombutton({super.key, required this.text, required this.ontap});

  VoidCallback ontap;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: MaterialButton(
        onPressed: ontap,

        height: 40,
        child: Text(text,style:TextStyle(color: Colors.white,fontSize: 20)),

      ),
    );
  }
}
