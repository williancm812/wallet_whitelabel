library wallet_whitelabel;

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/br_code_preview.dart';
import 'package:wallet_whitelabel/models/pix_created.dart';

class PixService {
  static final PixService _instance = PixService.internal();

  factory PixService() => _instance;

  PixService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> receivePix({
    @required String? email,
    @required String? token,
    @required int? amount,
    @required String? name,
    @required String? taxId,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/invoice/new',
        body: {
          "amount": amount,
          "name": name,
          "taxId": taxId,
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

      if (response.containsKey('invoiceCreated') && response['invoiceCreated'] == 0) {
        throw Exception("Not Create Receiver Pix");
      }

      return ApiResponse(response: PixCreated.fromJson(response));
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> brCodePreview({
    @required String? email,
    @required String? token,
    @required String? brCode,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/pix/brcode-preview',
        body: {
          "brcode": brCode,
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

      if (response.containsKey('errorCode')) {
        return ApiResponse(errorMessage: response['errorCode'].toString());
      }

      return ApiResponse(response: BrCodePreview.fromJson(response));
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> payPix({
    @required String? email,
    @required String? token,
    @required int? amount,
    @required String? brCode,
    @required String? taxId,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/pix/pay',
        body: {
          "amount": amount,
          "brcode": brCode,
          "taxId": taxId,
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

      if (response.containsKey('created') && response['created'] == 0) {
        throw Exception("Not Create Receiver Pix");
      }

      return ApiResponse(response: response['creationTime']);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
