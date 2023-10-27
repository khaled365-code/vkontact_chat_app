import 'package:firebase_chat_app/views/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';







class Splashscreen extends StatefulWidget {



  static String id='splashScreen';

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    super.initState();
    getDelayed();
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[200],
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey[200],
        ),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 220),
              child: Center(child: Icon(Icons.message_outlined,size: 80,))),
          SizedBox(height: 10,),
          Text('VKontact',style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: 'Gramound'),)
        ],
      ),



    );
  }

  getDelayed() async
  {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushNamed(context, Signinscreen.id );
  }
}
