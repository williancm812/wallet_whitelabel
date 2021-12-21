import 'package:flutter/material.dart';

import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/boleto_created.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
// import 'package:wallet_whitelabel/api/api_service.dart';

class BoletoService {
  static final BoletoService _instance = BoletoService.internal();

  factory BoletoService() => _instance;

  BoletoService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> createBoleto({
    @required String? email,
    @required String? token,
    @required int? amount,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/boleto/create',
        body: {
          'amount': amount,
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

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      if (response.containsKey('created') && response['created'] == 0) throw Exception("Not Create Boleto");

      return ApiResponse(response: BoletoCreated.fromJson(response));
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> payingBoleto({
    @required String? email,
    @required String? token,
    @required String? line,
    @required String? taxId,
    @required bool? typed,
  }) async {
    // https://development-dot-rodopay.uc.r.appspot.com/wallet/boleto/payment
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/boleto/payment',
        body: {
          "description": "Pagamento de boleto",
          if (typed!) "line": line else "barCode": line,
          "taxId": taxId,
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

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      if (response.containsKey('paymentCreated') && response['paymentCreated'] == 0) {
        switch (response['errorCode'].toString()) {
          case 'invalidPayment':
            return ApiResponse(
                errorMessage: 'A linha digitada não é válida ou'
                    ' o pagamento já foi registrado ou o boleto está vencido');
          case 'immediatePaymentOutOfTime':
            return ApiResponse(errorMessage: 'Pagamento fora do limite horário');
          default:
            return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
        }
      }

      return ApiResponse(response: response['creationTime']);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> payingContaConsumo({
    @required String? email,
    @required String? token,
    @required String? line,
    @required bool? typed,
  }) async {
    // https://development-dot-cashedu.uc.r.appspot.com/wallet/boleto/payment
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/wallet/utility/payment',
        body: {
          "description": "Pagamento de conta de consumo",
          if (typed!) "line": line else "barCode": line,
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

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      if (response.containsKey('paymentCreated') && response['paymentCreated'] == 0) {
        switch (response['errorCode'].toString()) {
          case 'invalidPayment':
            return ApiResponse(
                errorMessage: 'A linha digitada não é válida ou'
                    ' o pagamento já foi registrado ou o boleto está vencido');
          case 'immediatePaymentOutOfTime':
            return ApiResponse(errorMessage: 'Pagamento fora do limite horário');
          default:
            return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
        }
      }

      return ApiResponse(response: response['creationTime']);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
