import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginToAccount(TextEditingController emailText,
      TextEditingController passwordText) async {
    emit(LoginLoadingState());
    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailText.text, password: passwordText.text);

      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(errorMessage: 'Wrong password'));
      }
    } catch (e) {
      emit(
          LoginFailureState(errorMessage: 'There is an error try again later'));
    }
  }

  Future<void> registerNewAccount(
      {required TextEditingController emailText,
      required TextEditingController passwordText}) async {
    emit(RegisterLoading());
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailText.text,
        password: passwordText.text,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'Email already in use'));
      }
    } catch (ex) {
      emit(RegisterFailure(errorMessage: 'There is an error try again later'));
    }
  }



}
