

import 'package:firebase_chat_app/constants.dart';
import 'package:flutter/foundation.dart';

class Messagemodel
{

  final String messageText;
  final String id;

  Messagemodel(this.messageText,this.id);


  factory Messagemodel.fromJson(json)
  {
    return Messagemodel(json[kmessage],json[kuserTd]);
  }



}