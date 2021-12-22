library wallet_whitelabel;

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';

class TransferService {
  static final TransferService _instance = TransferService.internal();

  factory TransferService() => _instance;

  TransferService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> createTransaction({
    @required String? email,
    @required String? token,
    @required int? amount,
    @required String? receiverId,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/transaction/create',
        body: {
          'amount': amount,
          'receiverId': receiverId,
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

      if (response.containsKey('transferCreated') && response['transferCreated'] == 0) {
        throw Exception("Not Create Transation");
      }

      return ApiResponse(response: response['creationTime']);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> createTransfer({
    @required String? email,
    @required String? token,
    @required int? amount,
    @required String? accountNumber,
    @required String? bankCode,
    @required String? branchCode,
    @required bool? isPix,
    @required String? name,
    @required bool? saveContact,
    @required String? taxId,
    String? ispb,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/transfer/create',
        body: {
          "accountNumber": accountNumber,
          "amount": amount,
          "bankCode": bankCode,
          "branchCode": branchCode,
          "isPix": isPix,
          if (isPix!) 'ispb': ispb,
          "name": name,
          "saveContact": saveContact,
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

      if (response.containsKey('transferCreated') && response['transferCreated'] == 0) {
        return ApiResponse(errorMessage: response['errorCode'] ?? "ERROR");
      }

      return ApiResponse(response: response['creationTime']);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
