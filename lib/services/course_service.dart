

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/services/api/api_service.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/course.dart';

class CourseService {
  static final CourseService _instance = CourseService.internal();

  factory CourseService() => _instance;

  CourseService.internal();

  final ApiService _apiService = ApiService();

  Future<ApiResponse?> saveCourse(Course? course, String? email) async {
    try {
      Map<String, dynamic> response = await _apiService.post(
        query: '/course/new',
        body: course!.toJson(),
        customHeader: {'email': email},
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      //CHECAGEM DE AUTENTICAÇÃO
      if (response.containsKey('auth') || response['auth'] == 0) {
        return ApiResponse(authError: true);
      }

      if (response['errorCode'] != 0) {
        throw Exception("User Not Autheticated");
      }

      return ApiResponse(response: response['result'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> updateCourse(Course? course, String? email) async {
    try {
      Map<String, dynamic> response = await _apiService.put(
        query: '/course/update',
        body: course!.toJson(),
        customHeader: {'email': email},
      );

      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      //CHECAGEM DE AUTENTICAÇÃO
      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      if (response['errorCode'] != 0) throw Exception("User Not Autheticated");

      return ApiResponse(response: response['result'] == 1);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> getInfo(String email) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/course/info',
        customHeader: {'email': email},
      );

      debugPrint(response.toString());
      //CHECAGEM ERRO
      if (response.containsKey('connection') || response.containsKey('error')) {
        throw Exception("Connection TimeOut");
      }

      if (response.containsKey('auth') || response['auth'] == 0) return ApiResponse(authError: true);

      List data = response['data'] as List;
      Course? course;
      if (data.isNotEmpty) course = Course.fromJson(data.first);

      return ApiResponse(response: course!);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }

  Future<ApiResponse?> getYearReceipt({
    @required String? email,
    @required String? token,
  }) async {
    try {
      Map<String, dynamic> response = await _apiService.get(
        query: '/course/year_receipt/info',
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

      if (response.containsKey("auth") && response['auth'] == 0) {
        return ApiResponse(errorMessage: 'Ocorreu um erro de autenticação');
      }

      return ApiResponse(response: response);
    } catch (e) {
      debugPrint(e.toString());
      return ApiResponse(errorMessage: 'Ocorreu um erro inesperado');
    }
  }
}
