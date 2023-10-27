import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());


  Future<void> loginToAccount(TextEditingController emailText,TextEditingController passwordText ) async
  {
    emit(LoginLoadingState());
    try
    {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailText.text,
          password: passwordText.text);

      emit(LoginSuccessState());

    } on FirebaseAuthException catch (e)
    {
      if (e.code == 'user-not-found')
      {
         emit(LoginFailureState(errorMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
         emit(LoginFailureState(errorMessage: 'wrong-password' ));
      }
    }
    catch (e)
    {
         emit(LoginFailureState(errorMessage: 'There is an error try again later'));
    }


  }
}
