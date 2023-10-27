import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/constants.dart';
import 'package:firebase_chat_app/cubits/eye_register_cubit/eye_register_cubit.dart';
import 'package:firebase_chat_app/cubits/register_cubit/register_cubit.dart';
import 'package:firebase_chat_app/views/chat_page.dart';
import 'package:firebase_chat_app/views/signin_page.dart';
import 'package:firebase_chat_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';


class Registerscreen extends StatelessWidget {


  static String id = 'registerpage';

  var emailText = TextEditingController();

  var passwordText = TextEditingController();

  var registerFormKey = GlobalKey<FormState>();

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {

    var eyeCubit=BlocProvider.of<EyeRegisterCubit>(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
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
                        Center(child: Icon(Icons.message,size: 80,)),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Let\'s create an account for you ! ',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailText,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required';
                            } else if (value.length < 5) {
                              return 'Email address is incorrect ';
                            }
                            return null;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.5),
                                fontSize: 18,
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                              suffixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                                size: 25,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ))
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<EyeRegisterCubit, EyeRegisterState>(
                          builder: (context, state) {
                            return TextFormField(
                              controller: passwordText,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.black, fontSize: 18),
                              obscureText: eyeCubit.obsecureText,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(.5),
                                    fontSize: 18,
                                  ),
                                  fillColor: Colors.grey[100],
                                  filled: true,
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        eyeCubit.eyeRegisterChange();
                                      },
                                      child: eyeCubit.eyeDissapear ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.black,
                                        size: 25,
                                      ) : Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black,
                                        size: 25,
                                      )),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ))
                                  ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Custombutton(
                            text: 'Register',
                            ontap: () async {
                              if (registerFormKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerNewAccount(emailText: emailText,
                                    passwordText: passwordText);

                              }
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member ? ',
                              style: TextStyle(color: Colors.black, fontSize: 18),
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
