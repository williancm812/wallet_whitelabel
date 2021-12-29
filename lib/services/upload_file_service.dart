import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/tag_enum.dart';
import 'package:wallet_whitelabel/services/api/api_service.dart';

class UploadFileService {
  static final UploadFileService _instance = UploadFileService.internal();

  factory UploadFileService() => _instance;

  UploadFileService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> uploadFile({
    @required File? file,
    @required String? email,
    TagEnum? tag,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.postFile(
        file: file!,
        tag: tag?.getName ?? 'others',
        customHeader: {'email': email},
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      debugPrint(response.toString());
      return ApiResponse(response: response['inserted'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
