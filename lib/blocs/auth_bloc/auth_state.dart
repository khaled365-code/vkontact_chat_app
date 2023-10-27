part of 'auth_bloc.dart';

@immutable
abstract class AuthBlocState {}

class LoginInitial extends AuthBlocState {}


class LoginSuccessState extends AuthBlocState {}
class LoginLoadingState extends AuthBlocState {}
class LoginFailureState extends AuthBlocState {

  final String errorMessage;
  LoginFailureState({required this.errorMessage});
}

class RegisterLoading extends AuthBlocState {}

class RegisterSuccess extends AuthBlocState {}

class RegisterFailure extends AuthBlocState {

  final String errorMessage;
  RegisterFailure({required this.errorMessage});

}