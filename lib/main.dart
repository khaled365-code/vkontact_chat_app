import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_chat_app/cubits/eye_login_cubit/eye_login_cubit.dart';
import 'package:firebase_chat_app/cubits/eye_register_cubit/eye_register_cubit.dart';
import 'package:firebase_chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:firebase_chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:firebase_chat_app/views/chat_page.dart';
import 'package:firebase_chat_app/views/register_page.dart';
import 'package:firebase_chat_app/views/signin_page.dart';
import 'package:firebase_chat_app/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user= FirebaseAuth.instance.currentUser;
  if(user==null)
    {
      isLogin=false;
    }
  else
    {
      isLogin=true;
    }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => RegisterCubit(),),
        BlocProvider(create: (context) => EyeLoginCubit(),),
        BlocProvider(create: (context) => EyeRegisterCubit(),),
        BlocProvider(create: (context) => ChatCubit(),),




      ],
      child: MaterialApp(
        routes: {
          Signinscreen.id: (context) => Signinscreen(),
          Registerscreen.id: (context) => Registerscreen(),
          Chatscreen.id: (context) => Chatscreen(),
          Splashscreen.id: (context) => Splashscreen(),

        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.grey[200],
            ),
          )
        ),
        debugShowCheckedModeBanner: false,
        home: isLogin! ? Chatscreen() : Splashscreen()
      ),
    );
  }
}

