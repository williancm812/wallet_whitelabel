
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/contact.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class ContactService {
  static final ContactService _instance = ContactService.internal();

  factory ContactService() => _instance;

  ContactService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> listContancts({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/wallet/contact/list',
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
      List<Contact> itens = (response['data'] as List).map((e) => Contact.fromJson(e)).toList();

      return ApiResponse(response: itens);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> searchUser({
    @required String? email,
    @required String? token,
    @required String? key,
    @required String? type,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/user/search',
        customHeader: {
          'email': email,
          'token': token,
        },
        body: {
          'document': key,
          'documentType': type,
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
      return ApiResponse(response: Contact.fromSearch(response));
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
