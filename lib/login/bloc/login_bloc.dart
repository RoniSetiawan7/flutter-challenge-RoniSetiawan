import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_ronisetiawan/login/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final loginRepository = LoginRepository();

  bool passwordVisibility = true;

  LoginBloc() : super(LoginInitial()) {
    on<PostLoginData>((event, emit) async {
      if (username.text.isEmpty && password.text.isEmpty ||
          username.text.isEmpty ||
          password.text.isEmpty) {
        emit(EmptyLoginField());
      }

      if (formKey.currentState!.validate()) {
        emit(LoginLoading());
        await loginRepository
            .postLoginData(username.text, password.text)
            .then((_) {
          emit(LoginSuccess());
        }).onError((error, stackTrace) {
          emit(LoginFailed(error.toString()));
        });
      }
    });

    on<ChangePasswordVisibility>((event, emit) {
      emit(ObsecureText(passwordVisibility = !passwordVisibility));
    });
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    return null;
  }
}
