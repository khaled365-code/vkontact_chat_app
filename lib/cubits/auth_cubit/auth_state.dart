part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginSuccessState extends AuthState {}
class LoginLoadingState extends AuthState {}
class LoginFailureState extends AuthState {

  String errorMessage;
  LoginFailureState({required this.errorMessage});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {

  final String errorMessage;
  RegisterFailure({required this.errorMessage});

}
