import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_chat_app/models/message_model.dart';
import 'package:firebase_chat_app/views/signin_page.dart';
import 'package:firebase_chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';

import '../widgets/custom_send_text_field.dart';


class Chatscreen extends StatelessWidget {

  static String id = 'chatPage';
  final scrollController = ScrollController();

  final sendText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
     backgroundColor:  Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          email.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      text: 'Are you sure?\nDo you want to logout',
                      cancelBtnText: 'Cancel',
                      confirmBtnText: 'yes',
                      confirmBtnColor: Colors.white,
                      backgroundColor: Colors.black,
                      headerBackgroundColor: Colors.grey,
                      confirmBtnTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textColor: Colors.white,
                      onCancelBtnTap: () {
                        Navigator.pop(context);
                      },
                      onConfirmBtnTap: ()  {
                         FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, Signinscreen.id);
                      });
                },
                child: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor:  Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List<Messagemodel> messageList =
                    BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return messageList[index].id == email
                        ? Chatbubble(
                            message: messageList[index],
                          )
                        : ChatbubbleforFriend(message: messageList[index]);
                  },
                  itemCount: messageList.length,

                );
              },
            ),
          ),
          SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.only(bottom: 10,left: 12,right: 8,top: 10),
             child: Row(
                  children: [
                  CustomSendChatField(
                    controller: sendText,
                    maxLines: 30,
                    hintText: 'Let\'s Gooooooo!!!!!',
                    onSubmitted: (value) {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessages(value, email.toString());
                      Timer(const Duration(milliseconds: 500),
                              () => scrollController.jumpTo(scrollController.position.maxScrollExtent));
                      sendText.clear();
                      // scrollController.animateTo(
                      //     scrollController.position.maxScrollExtent,
                      //     duration: Duration(milliseconds: 0),
                      //     curve: Curves.ease);
                    },
                  ),
                  const SizedBox(width: 5,),
                    InkWell(
                    onTap: () {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessages(sendText.text, email.toString());
                      sendText.clear();
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child: const Icon(
                      Icons.arrow_circle_up_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ],
                ),
           ),
         ),


        ],
      ),
    );
  }
}


