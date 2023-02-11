part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginData extends LoginEvent {}

class ChangeObsecureText extends LoginEvent {}
