library wallet_whitelabel;

import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/extract_item.dart';
import 'package:wallet_whitelabel/models/wallet.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class ExtractService {
  static final ExtractService _instance = ExtractService.internal();

  factory ExtractService() => _instance;

  ExtractService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> extractList({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/wallet/operation/list',
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

      List<ExtractItem> itens = (response['data'] as List).map((e) => ExtractItem.fromJson(e)).toList();

      return ApiResponse(response: itens);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
