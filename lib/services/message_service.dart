
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/message.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class MessageService {
  static final MessageService _instance = MessageService.internal();

  factory MessageService() => _instance;

  MessageService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> search({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/message/search',
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      print(response);

      ///CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0)
        return ApiResponse(authError: true);

      List<Message> items = (response['data'] as List).map((e) => Message.fromJson(e)).toList();

      return ApiResponse(response: items);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> readMessage({
    @required String? email,
    @required String? token,
    @required num? id,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.put(
        query: '/message/read',
        body: {
          "idMessage": id,
        },
        customHeader: {
          'email': email,
          'token': token,
        },
      );

      print(response);

      ///CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0)
        return ApiResponse(authError: true);

      if (response.containsKey('updated') && response['updated'] == 0)
        throw Exception("Not Create Receiver Pix");

      return ApiResponse(response: response['updated'] == 1);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
