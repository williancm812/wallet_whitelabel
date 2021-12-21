library wallet_whitelabel;

import 'dart:io';

import 'package:wallet_whitelabel/models/file_app.dart';
import 'package:wallet_whitelabel/models/tag_enum.dart';

import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/api/api_service.dart';
import 'package:flutter/material.dart';

class FileService {
  static final FileService _instance = FileService.internal();

  factory FileService() => _instance;

  FileService.internal();

  ApiService _apiService = ApiService();

  Future<ApiResponse?> getFiles({
    @required String? email,
    TagEnum? tag,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        fromFileApi: true,
        query: '/professional/files/list' + (tag == null ? '' : '/${tag.getName}'),
        customHeader: {'email': email},
      );

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);


      print(response);
      print((response['data'] as List).length);
      List<FileApp> files = (response['data'] as List).map((e) => FileApp.fromJson(e)).toList();

      return ApiResponse(response: files);
    } catch (e) {
      print(e);
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
