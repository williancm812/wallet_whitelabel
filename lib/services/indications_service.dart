library wallet_whitelabel;

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/indication.dart';

class IndicationsService {
  static final IndicationsService _instance = IndicationsService.internal();

  factory IndicationsService() => _instance;

  IndicationsService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> search({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/indications/search',
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      debugPrint(response.toString());
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      List<Indication> itens = (response['data'] as List).map((e) => Indication.fromJson(e)).toList();

      return ApiResponse(response: itens);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> viewer({
    @required String? email,
    @required String? token,
    @required num? idIndication,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/indications/viewer',
        body: {
          "idIndication": idIndication,
        },
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      debugPrint(response.toString());
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      return ApiResponse(response: response['inserted'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> send({
    @required String? email,
    @required String? token,
    @required String? toEmail,
    @required String? toName,
    @required num? idIndication,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/indications/send',
        body: {
          "idIndication": idIndication,
          "toEmail": toEmail,
          "toName": toName,
        },
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      debugPrint(response.toString());
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      return ApiResponse(response: response['inserted'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
