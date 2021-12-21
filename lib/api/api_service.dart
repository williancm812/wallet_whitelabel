library wallet_whitelabel;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  static final ApiService _instance = ApiService.internal();

  factory ApiService() => _instance;

  ApiService.internal();

  void initialize({String? url, String? fileUrl}) {
    this.url = url!;
    this.fileUrl = fileUrl!;
  }

  String? url;
  String? fileUrl;

  Future<Map<String, dynamic>> get({
    @required String? query,
    Map<String, dynamic>? customHeader,
    bool fromFileApi = false,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {

      String currentUrl = (fromFileApi ? fileUrl : url)! + query!;
      debugPrint(currentUrl);
      debugPrint(customHeader.toString());
      
      Response response = await Dio()
          .get(
            currentUrl,
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }..addAll(customHeader ?? {}),
            ),
          )
          .timeout(duration);

      if (response.data is List) {
        response.data = {"data": response.data};
      }
      return response.data;
    } on TimeoutException catch (e) {
      return {'connection': e.toString()};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> post({
    @required String? query,
    bool fromFileApi = false,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? customHeader,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      String currentUrl = (fromFileApi ? fileUrl : url)! + query!;
      debugPrint(currentUrl);
      debugPrint(body.toString());

      Response response = await Dio()
          .post(
            currentUrl,
            data: jsonEncode(body ?? {}),
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }..addAll(customHeader ?? {}),
            ),
          )
          .timeout(duration);

      if (response.data is List) {
        response.data = {"data": response.data};
      }
      return response.data;
    } on TimeoutException catch (e) {
      debugPrint('AQUI');
      return {'connection': e.toString()};
    } catch (e) {
      debugPrint('AQUI2 ${e.toString()}');
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> put({
    @required String? query,
    bool fromFileApi = false,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? customHeader,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      String currentUrl = (fromFileApi ? fileUrl : url)! + query!;
      debugPrint(currentUrl);
      debugPrint(body.toString());

      Response response = await Dio()
          .put(
            currentUrl,
            data: jsonEncode(body ?? {}),
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json",
              }..addAll(customHeader ?? {}),
            ),
          )
          .timeout(duration);

      if (response.data is List) {
        response.data = {"data": response.data};
      }
      return response.data;
    } on TimeoutException catch (e) {
      debugPrint('AQUI');
      return {'connection': e.toString()};
    } catch (e) {
      debugPrint('AQUI2 ${e.toString()}');
      return {'error': e.toString()};
    }
  }

  Future<Map<String, dynamic>> postFile({
    @required File? file,
    @required String? tag,
    Map<String, dynamic>? customHeader,
    Duration duration = const Duration(seconds: 10),
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file!.path, filename: file.path.split("/").last),
        "tagName": tag,
      });

      Response response = await Dio().post(
        "$fileUrl/professional/files/upload",
        data: formData,
        options: Options(headers: customHeader ?? {}),
      );

      if (response.data is List) {
        response.data = {"data": response.data};
      }
      return response.data;
    } on TimeoutException catch (e) {
      debugPrint('AQUI');
      return {'connection': e.toString()};
    } catch (e) {
      debugPrint('AQUI2 ${e.toString()}');
      return {'error': e.toString()};
    }
  }
}
