import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_chat_app/models/message_model.dart';
import 'package:firebase_chat_app/views/signin_page.dart';
import 'package:firebase_chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/quickalert.dart';


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
          style: TextStyle(color: Colors.white, fontSize: 18),
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
                      text: 'Are you sure?                                Do you want to logout',
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
                      onConfirmBtnTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, Signinscreen.id);
                      });
                },
                child: Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor:  Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                List<Messagemodel> messageList=BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(

                  controller: scrollController,
                  itemBuilder:
                      (context, index)
                  {
                    return messageList[index].id == email ? Chatbubble(
                      message: messageList[index],) : ChatbubbleforFriend(
                        message: messageList[index]);
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
                    Container(
                      width: 285,
                      height: 60,
                      child: TextField(
                        controller: sendText,
                        maxLines: 30,
                        onSubmitted: (value) {
                          BlocProvider.of<ChatCubit>(context).sendMessages(value, email.toString());
                          sendText.clear();
                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                          },
                        decoration: InputDecoration(
                          hintText: 'Let\'s Gooooooo!!!!!',
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
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                    onTap: () {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessages(sendText.text, email.toString());
                      sendText.clear();
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child: Icon(
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
