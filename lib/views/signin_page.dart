import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:firebase_chat_app/cubits/eye_login_cubit/eye_login_cubit.dart';
import 'package:firebase_chat_app/views/chat_page.dart';
import 'package:firebase_chat_app/views/register_page.dart';
import 'package:firebase_chat_app/widgets/custom_button.dart';
import 'package:firebase_chat_app/widgets/custom_login_password_text_field.dart';
import 'package:firebase_chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/quickalert.dart';

import '../blocs/auth_bloc/auth_bloc.dart';


class Signinscreen extends StatelessWidget {


  static String id = 'loginPage';
  var emailText = TextEditingController();

  var passwordText = TextEditingController();

  var loginFormKey = GlobalKey<FormState>();

  bool eyeDissapear = true;
  bool textSecured = true;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var eyeCubit = BlocProvider.of<EyeLoginCubit>(context);
    return BlocConsumer<AuthBloc, AuthBlocState>(
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
               
                backgroundColor: Colors.grey[200],
                body: SafeArea(
                    child:SingleChildScrollView(
                      child: Padding(
                          padding:  EdgeInsets.only(left: 20,right:20,top: 30),
                          child: Form(
                            key: loginFormKey,
                            child: Column(

                              children: [
                                 Center(child: Icon(Icons.message,size: 80,)),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  'Welcome back you have been missed !',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                    hintText: 'Email',
                                    controller: emailText,
                                    icon: Icons.email),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomLoginPasswordField(
                                    controller: passwordText,
                                    eyeCubit: eyeCubit),
                                SizedBox(
                                  height: 10,
                                ),
                                Custombutton(
                                    text: 'Sign in',
                                    ontap: () {
                                      if (loginFormKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          LoginPressed(email: emailText, password: passwordText)
                                        );

                                      }
                                    }),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'don\'t have an account ? ',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                        onTap: () {},
                                        child: InkWell(
                                            onTap: () {
                                              emailText.clear();
                                              passwordText.clear();
                                              Navigator.pushNamed(
                                                  context, Registerscreen.id);
                                            },
                                            child: Text(
                                              'Sign up',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 16),
                                            ))),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                    ),
                )));
      }, listener: (context, state) {
        if (state is LoginSuccessState) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(
              context, Chatscreen.id, arguments: emailText.text);
        }
        else if (state is LoginLoadingState) {
          isLoading = true;
        }
        else if (state is LoginFailureState) {
          isLoading = false;
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.errorMessage
          );
        }
      },
    );
  }
}






