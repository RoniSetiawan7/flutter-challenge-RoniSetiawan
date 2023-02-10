part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String message;

  const LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}

class EmptyLoginField extends LoginState {}

class ObsecureText extends LoginState {
  final bool visibility;

  const ObsecureText(this.visibility);

  @override
  List<Object> get props => [visibility];
}
