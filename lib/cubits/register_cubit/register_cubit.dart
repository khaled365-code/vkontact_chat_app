import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());


  Future<void> registerNewAccount({required TextEditingController emailText ,required TextEditingController passwordText }) async
  {

    emit(RegisterLoading());
    try
    {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailText.text,
        password: passwordText.text,
      );
      emit(RegisterSuccess());
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
      {
         emit(RegisterFailure(errorMessage: 'weak-password' ));
      } else if (e.code == 'email-already-in-use')
      {
        emit(RegisterFailure(errorMessage: 'email-already-in-use'));
      }
    } catch (ex)
    {
       emit(RegisterFailure(errorMessage: 'There is an error try again later'));
    }


  }
}
