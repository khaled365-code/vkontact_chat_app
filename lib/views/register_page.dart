import 'package:firebase_chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:firebase_chat_app/cubits/eye_register_cubit/eye_register_cubit.dart';
import 'package:firebase_chat_app/views/chat_page.dart';
import 'package:firebase_chat_app/widgets/custom_button.dart';
import 'package:firebase_chat_app/widgets/custom_register_password_text_field.dart';
import 'package:firebase_chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class Registerscreen extends StatelessWidget {


  static String id = 'registerpage';

  final emailText = TextEditingController();

  final passwordText = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {

    var eyeCubit=BlocProvider.of<EyeRegisterCubit>(context);
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        }
        else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(
              context, Chatscreen.id, arguments: emailText.text);
        }
        else if (state is RegisterFailure) {
          isLoading = false;
          QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: state.errorMessage
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right:20,top: 30),
                  child: Form(
                    key: registerFormKey,
                    child: Column(
                      children: [
                        const Center(child: Icon(Icons.message,size: 80,)),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Let\'s create an account for you ! ',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: 'Email',
                            controller: emailText,
                            icon: Icons.email),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomRegisterPasswordField(
                            passwordController: passwordText,
                            eyeCubit: eyeCubit),
                        const SizedBox(
                          height: 10,
                        ),
                        Custombutton(
                            text: 'Register',
                            ontap: () async {
                              if (registerFormKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  RegisterPressed(email: emailText, password: passwordText));

                              }
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already a member ? ',
                              style: TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {},
                                child: InkWell(
                                    onTap: () {
                                      emailText.clear();
                                      passwordText.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Colors.grey[800], fontSize: 16),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  ),


                ),
              ),
            ),


          )
          ,
        );
      },
    );
  }

/*Future<void> registerUser(BuildContext context) async {
          final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailText.text,
           password: passwordText.text,
          );

    /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          content: Text('Account is created successfully',
            style: TextStyle(color: Colors.white,
                fontSize: 30),)),);*/
      }*/
}
