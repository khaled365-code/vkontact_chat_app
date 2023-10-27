part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocEvent {}

class LoginPressed extends AuthBlocEvent{

  final TextEditingController email;
  final TextEditingController password;

  LoginPressed({required this.email,required this.password});

}

class RegisterPressed extends AuthBlocEvent{

  final TextEditingController email;
  final TextEditingController password;

  RegisterPressed({required this.email,required this.password});


}
