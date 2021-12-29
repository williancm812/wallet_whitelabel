import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/course.dart';
import 'package:wallet_whitelabel/models/file_app.dart';
import 'package:wallet_whitelabel/models/tag_enum.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/course_service.dart';
import 'package:wallet_whitelabel/services/file_service.dart';
import 'package:wallet_whitelabel/services/professional_service.dart';
import 'package:wallet_whitelabel/services/sign_up_service.dart';
import 'package:wallet_whitelabel/services/upload_file_service.dart';

class SignUpManager extends ChangeNotifier {
  final SignUpService _signUpService = SignUpService();
  final CourseService _courseService = CourseService();
  final UploadFileService _uploadFileService = UploadFileService();
  final ProfessionalService _professionalService = ProfessionalService();
  final FileService _fileService = FileService();
  User? user = User();
  Course? course = Course();

  String? tokenSocialNetwork;

  dynamic _perfilPicture;
  dynamic _provaDeVidaBack;
  dynamic _provaDeVidaFront;

  int? expirationMilliseconds;

  Future<bool?> verifyEmailExists({@required String? email}) async {
    ApiResponse? aux = await _signUpService.verifyEmailExists(email: email!);
    if (aux!.isValid ?? false) {
      return aux.response as bool;
    } else {
      return true;
    }
  }

  Future<bool?> verifyCpfExists({@required String? cpf}) async {
    ApiResponse? aux = await _signUpService.verifyCpfExists(cpf: cpf!);
    if (aux!.isValid ?? false) {
      return aux.response as bool;
    }
    return true;
  }

  Future<String?> saveCourse() async {
    ApiResponse? aux = await _courseService.saveCourse(course!, user!.email);
    if (aux!.isValid ?? false) {
      if (aux.response as bool) return null;
    }
    return aux.errorMessage;
  }

  Future<String?> registerUser() async {
    ApiResponse? aux = await _signUpService.newRegister(user: user!);

    if (aux!.isValid ?? false) {
      user = aux.response as User;
      notifyListeners();
    }

    return aux.errorMessage;
  }

  Future<String?> registerSocialNetworkUser() async {
    ApiResponse? aux = await _signUpService.newSocialNetworkRegister(user: user!, token: tokenSocialNetwork);

    if (aux!.isValid ?? false) {
      user = aux.response as User;
      notifyListeners();
    }

    return aux.errorMessage;
  }

  Future<String?> registerCode() async {
    ApiResponse? aux = await _signUpService.registerCode(userRegister: user);

    if (aux!.isValid ?? false) {
      expirationMilliseconds = aux.response;
    }

    return aux.errorMessage;
  }

  Future<String?> verifyRegisterCode() async {
    ApiResponse? aux = await _signUpService.verifyCode(email: user!.email, code: user!.code);

    if (aux!.isValid ?? false) {
      if (!aux.response) {
        return 'Código inválido';
      }
    }

    return aux.errorMessage;
  }

  Future<void> getFiles({TagEnum? tag}) async {
    ApiResponse? aux = await _fileService.getFiles(
      tag: tag,
      email: user!.email,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    try {
      List<FileApp> files = aux.response as List<FileApp>;

      try {
        _provaDeVidaFront = files
            .firstWhere(
              (element) => element.tag == TagEnum.lifeProofFront.getName,
        )
            .externalUrl;
      } catch (e) {}

      try {
        _provaDeVidaBack = files
            .firstWhere(
              (element) => element.tag == TagEnum.lifeProofBack.getName,
        )
            .externalUrl;
      } catch (e) {}

      try {
        _perfilPicture = files
            .firstWhere(
              (element) => element.tag == TagEnum.profile.getName,
        )
            .externalUrl;
      } catch (e) {}
    } catch (e) {}
  }

  Future<String?> uploadFile(File? file, TagEnum? tag, {String? email}) async {
    ApiResponse? aux = await _uploadFileService.uploadFile(
      file: file,
      tag: tag,
      email: email ?? user!.email,
    );
    if ((aux!.isValid ?? false) && aux.response) {
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> forgotPassword({@required String? email}) async {
    user!.email = email;
    ApiResponse? aux = await _professionalService.forgotPassword(
      email: email,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  Future<String?> verifyNewPasswordCode({
    @required String? code,
  }) async {

    user!.code= code;
    ApiResponse? aux = await _professionalService.verifyNewPasswordCode(
      email: user!.email,
      code: code!,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  Future<String?> updatePassword({
    @required String? password,
  }) async {
    ApiResponse? aux = await _professionalService.updatePassword(
      email: user!.email,
      code: user!.code,
      password: password!,
    );

    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  ///GET AND SETTERS

  dynamic get perfilPicture => _perfilPicture;

  set perfilPicture(dynamic value) {
    _perfilPicture = value;

    notifyListeners();
  }

  dynamic get provaDeVidaBack => _provaDeVidaBack;

  set provaDeVidaBack(dynamic value) {
    _provaDeVidaBack = value;
    notifyListeners();
  }

  dynamic get provaDeVida => _provaDeVidaFront;

  set provaDeVida(dynamic value) {
    _provaDeVidaFront = value;
    notifyListeners();
  }
}
