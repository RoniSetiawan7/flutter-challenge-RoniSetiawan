import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  Future<http.Response> postLoginData(String username, String password) {
    return http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-type': 'application/json'},
    );
  }
}
