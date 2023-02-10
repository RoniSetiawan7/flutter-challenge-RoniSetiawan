import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge_ronisetiawan/dashboard/dashboard.dart';
import 'package:flutter_challenge_ronisetiawan/login/bloc/login_bloc.dart';
import 'package:flutter_challenge_ronisetiawan/login/text_field.dart';
import 'package:flutter_challenge_ronisetiawan/login/widget/dialog.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Login Berhasil',
              content: 'Selamat anda berhasil masuk kedalam aplikasi IST',
              image: 'assets/icons/success.png',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    (route) => false);
              },
            ),
          );
        }

        if (state is LoginFailed) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Login Gagal',
              content: state.message,
              image: 'assets/icons/failed.png',
            ),
          );
        }

        if (state is EmptyLoginField) {
          showDialog(
            context: context,
            builder: (context) => const CustomDialog(
              title: 'Login Gagal',
              content: 'Username atau password belum diisi',
              image: 'assets/icons/failed.png',
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: context.read<LoginBloc>().formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset('assets/images/header-login.png'),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  label: 'Username',
                  hintText: 'Masukkan Username anda',
                  controller: context.read<LoginBloc>().username,
                  validator: context.read<LoginBloc>().usernameValidator,
                ),
                const SizedBox(height: 5),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return CustomTextField(
                      label: 'Password',
                      hintText: 'Masukkan Password anda',
                      controller: context.read<LoginBloc>().password,
                      validator: context.read<LoginBloc>().passwordValidator,
                      obsecureText:
                          context.read<LoginBloc>().passwordVisibility,
                      suffixIcon: context.read<LoginBloc>().passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixIconPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(ChangePasswordVisibility());
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(PostLoginData());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const CircularProgressIndicator(
                            color: Colors.white,
                          );
                        }
                        return const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
