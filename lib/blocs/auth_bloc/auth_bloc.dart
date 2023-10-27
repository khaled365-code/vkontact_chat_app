import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBloc() : super(LoginInitial()) {
    on<AuthBlocEvent>((event, emit)  async {
      if (event is LoginPressed) {
        emit(LoginLoadingState());
        try {
          UserCredential credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email.text, password: event.password.text);

          emit(LoginSuccessState());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailureState(errorMessage: 'User not found'));
          } else if (e.code == 'wrong-password') {
            emit(LoginFailureState(errorMessage: 'Wrong password'));
          }
        } catch (e) {
          emit(LoginFailureState(
              errorMessage: 'There is an error try again later'));
        }
      } else if (event is RegisterPressed) {
        emit(RegisterLoading());
        try {
          UserCredential credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email.text,
            password: event.password.text,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterFailure(errorMessage: 'Weak password'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage: 'Email already in use'));
          }
        } catch (ex) {
          emit(RegisterFailure(
              errorMessage: 'There is an error try again later'));
        }
      }

    });

  }

}
