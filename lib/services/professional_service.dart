library wallet_whitelabel;

import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class ProfessionalService {
  static final ProfessionalService _instance = ProfessionalService.internal();

  factory ProfessionalService() => _instance;

  ProfessionalService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> getInfo({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/professional/info',
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      List data = response['data'] as List;
      User? object;
      if (data.isNotEmpty) object = User.fromProfessionalInfo(data.first);

      return ApiResponse(response: object!);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> update({@required User? user}) async {
    try {

      Map<String, dynamic> response = await _apiService.put(
        query: '/professional/update',
        body: user!.toJson(),
        customHeader: {
          'email': user.email,
          'token': user.token,
        },
      );
      print(response);

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }
      //CHECAGEM DE AUTENTICAÇÃO
      if (response['errorCode'] != 0) {
        throw Exception(response['errorCode'].toString());
      }

      return ApiResponse(response: response['result'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> passwordCheck({
    @required String? email,
    @required String? password,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/password/check',
        body: {
          'password': password,
        },
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response['auth'] == 0) throw Exception("User Not Autheticated");

      return ApiResponse(response: response['valid'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> changePassword({
    @required String? email,
    @required String? password,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/change-password',
        body: {
          'email': email,
          'newPassword': password,
        },
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      // if (response['auth'] == 0) throw Exception("User Not Autheticated");

      return ApiResponse(response: response['passwordChanged'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> forgotPassword({
    @required String? email,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/forgot-password',
        body: {
          'email': email,
          'language': 'pt',
        },
      );

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response['tokenCreated'] == 0) return ApiResponse(errorMessage: 'Email não cadastrado');

      return ApiResponse(response: response['emailSent']);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> verifyNewPasswordCode({
    @required String? email,
    @required String? code,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/verify-new-password-code',
        body: {
          'email': email,
          'code': code,
        },
      );

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response['codeIsValid'] == 0) {
        return ApiResponse(errorMessage: 'Código inválido');
      }

      return ApiResponse(response: response['codeIsValid'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> updatePassword({
    @required String? email,
    @required String? password,
    @required String? code,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/professional/update-password',
        body: {
          'email': email,
          'newPassword': password,
          'code': code,
        },
      );

      print(response);

      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response['passwordChanged'] == 0) {
        throw Exception("Change Error");
      }

      return ApiResponse(response: response['passwordChanged'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
