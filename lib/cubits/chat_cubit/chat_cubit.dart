import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());


  CollectionReference messages = FirebaseFirestore.instance.collection(kmessagesCollection);
  final sendText=TextEditingController();

  List<Messagemodel> messageList=[];
  sendMessages(String message,String email)
  {

    try
    {
      messages.add({
        kmessage:message,
        kcreatedAt:DateTime.now(),
        kuserTd:email
      });
    }catch(e)
    {
      emit(ChatFailure());
    }

  }


  getMessages()
  {
    messages.orderBy(kcreatedAt).snapshots().listen((event) {

      messageList.clear();
      for(var doc in event.docs)
        {
          messageList.add(Messagemodel.fromJson(doc));
        }
      emit(ChatSuccess(messageList: messageList));
    });

  }




}
