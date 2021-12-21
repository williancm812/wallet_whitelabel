library wallet_whitelabel;

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/wallet.dart';

class WalletService {
  static final WalletService _instance = WalletService.internal();

  factory WalletService() => _instance;

  WalletService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> wallet({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/professional/wallet',
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

      return ApiResponse(response: Wallet.fromJson(response));
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> generateBRCode({
    @required String? email,
    @required String? token,
    @required num? value,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/wallet/pix/static/${value!.round()}',
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

      return ApiResponse(response: response['brcode']);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> balance({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/wallet/balance',
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

      return ApiResponse(response: Balance.fromJson(response));
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
