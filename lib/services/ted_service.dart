
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/ted_item.dart';
import 'package:wallet_whitelabel/models/wallet.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class TedService {
  static final TedService _instance = TedService.internal();

  factory TedService() => _instance;

  TedService.internal();

  ApiService _apiService = ApiService();

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

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0)
        return ApiResponse(authError: true);

      print(response);
      print((response['data'] as List).length);
      List<TedItem> itens = (response['data'] as List).map((e) => TedItem.fromJson(e)).toList();


      return ApiResponse(response: itens);
    } catch (e) {
      print(e);
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

      print(response);
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0)
        return ApiResponse(authError: true);

      print(response);
      print((response['data'] as List).length);
      List<TedItem> itens = (response['data'] as List).map((e) => TedItem.fromPixJson(e)).toList();


      return ApiResponse(response: itens);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
