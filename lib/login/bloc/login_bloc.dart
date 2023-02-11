import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_challenge_ronisetiawan/login/model/login.dart';
import 'package:flutter_challenge_ronisetiawan/login/repository/login_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final loginRepository = LoginRepository();

  bool obsecureText = true;

  LoginBloc() : super(LoginInitial()) {
    on<PostLoginData>((event, emit) async {
      if (username.text.isEmpty && password.text.isEmpty ||
          username.text.isEmpty ||
          password.text.isEmpty) {
        emit(EmptyLoginField());
      }

      if (formKey.currentState!.validate()) {
        emit(LoginLoading());
        final response =
            await loginRepository.postLoginData(username.text, password.text);

        if (response.statusCode == 200) {
          final res = Login.fromJson(jsonDecode(response.body));
          final userToken = res.token;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userToken', userToken);

          emit(LoginSuccess());
        } else {
          emit(LoginFailed(jsonDecode(response.body)['message']));
        }
      }
    });

    on<ChangeObsecureText>((event, emit) {
      emit(ObsecureText(obsecureText = !obsecureText));
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
