

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/services/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/user.dart';

class LoginService {
  static final LoginService _instance = LoginService.internal();

  factory LoginService() => _instance;

  LoginService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> login({@required String? email, @required String? password}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/login',
        body: {
          'email': email,
          'password': password,
        },
      );

      debugPrint(response.toString());

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      //CHECAGEM DE AUTENTICAÇÃO
      if (response['loggedIn'] == 0) throw Exception("User Not Autheticated");

      User u = User.fromLogin(response);
      u.email = email;
      // u.password = password;
      return ApiResponse(response: u);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> loginSocialNetwork({@required String? email, @required String? token}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/loginsocialnetwork',
        body: {
          'email': email,
          'token': token,
        },
      );

      debugPrint(response.toString());

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      //CHECAGEM DE AUTENTICAÇÃO
      if (response['loggedIn'] == 0) throw Exception("User Not Autheticated");

      User u = User.fromLogin(response);
      u.email = email;
      // u.password = password;
      return ApiResponse(response: u);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
