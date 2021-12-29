

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/services/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/user.dart';

class SignUpService {
  static final SignUpService _instance = SignUpService.internal();

  factory SignUpService() => _instance;

  SignUpService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> newRegister({@required User? user}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/new',
        body: user!.toJson(),
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      //CHECAGEM DE AUTENTICAÇÃO
      if (response['professionalCreated'] == 0) {
        return ApiResponse(errorMessage: response['message']);
      }

      return ApiResponse(response: user..onCreate(response));
    } catch (e) {
      debugPrint(e.toString());

      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> newSocialNetworkRegister({@required User? user, @required String? token}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/newsocialnetwork',
        body: user!.toJson(),
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      //CHECAGEM DE AUTENTICAÇÃO
      if (response['professionalCreated'] == 0) {
        return ApiResponse(errorMessage: response['message']);
      }

      return ApiResponse(response: user..onCreate(response));
    } catch (e) {
      debugPrint(e.toString());

      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> registerCode({@required User? userRegister}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/user/new/code',
        body: {
          'name': userRegister!.name,
          'email': userRegister.email,
        },
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception();
      }
      if (response['tokenCreated'] == 0) {
        return ApiResponse(errorMessage: response['message']);
      }

      return ApiResponse(response: response['expirationMilliseconds']);
    } catch (e) {
      debugPrint(e.toString());

      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> verifyEmailExists({@required String? email}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/user/new/email-verify-exists',
        body: {'email': email},
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      debugPrint(response.toString());
      return ApiResponse(response: response['emailExists'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> verifyCpfExists({@required String? cpf}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/user/new/cpf-verify-exists',
        body: {'cpf': cpf},
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      debugPrint(response.toString());
      return ApiResponse(response: response['cpfExists'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> verifyCode({@required String? email, @required String? code}) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/user/new/verify-register-code',
        body: {
          'email': email,
          'code': code,
        },
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      debugPrint(response.toString());
      return ApiResponse(response: response['codeIsValid'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
