import 'dart:convert';

import 'package:flutter_challenge_ronisetiawan/login/model/login.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<Login> postLoginData(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return Login.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to post login data.');
    }
  }
}
