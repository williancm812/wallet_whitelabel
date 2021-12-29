

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/services/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/ted_item.dart';

class TedService {
  static final TedService _instance = TedService.internal();

  factory TedService() => _instance;

  TedService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> listAvailableTed({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/bank/list/ted',
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

      debugPrint(response.toString());

      List<TedItem> itens = (response['data'] as List).map((e) => TedItem.fromJson(e)).toList();

      return ApiResponse(response: itens);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> listAvailablePix({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/bank/list/pix',
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

      debugPrint(response.toString());

      List<TedItem> itens = (response['data'] as List).map((e) => TedItem.fromPixJson(e)).toList();

      return ApiResponse(response: itens);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
