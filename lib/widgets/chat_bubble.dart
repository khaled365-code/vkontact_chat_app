import 'package:flutter/material.dart';

import '../models/message_model.dart';



class Chatbubble extends StatelessWidget {


  final Messagemodel message;
  Chatbubble({required this.message});


  @override
  Widget build(BuildContext context)
  {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsetsDirectional.only( start: 20,top: 10,end: 20),
        padding: EdgeInsetsDirectional.only(start: 15,top: 30,bottom: 30,end: 15) ,
        decoration: BoxDecoration(
          color: Color(0xff858585),
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(30),
              topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          )

        ),
        child: Text(message.messageText,style: TextStyle(color: Colors.white,fontSize: 18),),

      ),
    );

  }
}


class ChatbubbleforFriend extends StatelessWidget {


  final Messagemodel message;
  ChatbubbleforFriend({required this.message});


  @override
  Widget build(BuildContext context)
  {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsetsDirectional.only( start: 20,top: 10,end: 20),
        padding: EdgeInsetsDirectional.only(start: 15,top: 30,bottom: 30,end: 15) ,
        decoration: BoxDecoration(
            color: Color(0xff58A25B),
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )

        ),
        child: Text(message.messageText,style: TextStyle(color: Colors.white,fontSize: 18),),

      ),
    );

  }
}
