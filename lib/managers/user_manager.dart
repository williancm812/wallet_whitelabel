import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/course.dart';
import 'package:wallet_whitelabel/models/file_app.dart';
import 'package:wallet_whitelabel/models/indication.dart';
import 'package:wallet_whitelabel/models/message.dart';
import 'package:wallet_whitelabel/models/tag_enum.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/course_service.dart';
import 'package:wallet_whitelabel/services/file_service.dart';
import 'package:wallet_whitelabel/services/indications_service.dart';
import 'package:wallet_whitelabel/services/login_service.dart';
import 'package:wallet_whitelabel/services/message_service.dart';
import 'package:wallet_whitelabel/services/professional_service.dart';
import 'package:wallet_whitelabel/services/upload_file_service.dart';
import 'package:wallet_whitelabel/services/wallet_service.dart';

class UserManager extends ChangeNotifier {
  final LoginService _loginService = LoginService();
  final CourseService _courseService = CourseService();
  final FileService _fileService = FileService();
  final ProfessionalService _professionalService = ProfessionalService();
  final UploadFileService _uploadFileService = UploadFileService();
  final MessageService _messageService = MessageService();
  final IndicationsService _indicationsService = IndicationsService();

  List<Message> messages = [];
  List<Indication> indications = [];
  bool? newCourse;
  User? user = User();
  Course? course;

  dynamic _perfilPicture;
  dynamic _boleto;
  dynamic _provaDeVida;

  bool get hasNewNotifications => messages.any((e) => !(e.messageRead ?? true));

  Future<bool?> authUser({@required String? email, @required String? password}) async {
    ApiResponse? aux = await _loginService.login(email: email!, password: password!);
    if (aux!.isValid ?? false) {
      user = aux.response as User;
    } else {
      user = null;
    }
    notifyListeners();
    return user != null;
  }

  Future<bool?> authWithSocialNetwork({@required String? email, @required String? token}) async {
    ApiResponse? aux = await _loginService.loginSocialNetwork(email: email!, token: token!);
    if (aux!.isValid ?? false) {
      user = aux.response as User;
    } else {
      user = null;
    }
    notifyListeners();
    return user != null;
  }

  Future<String?> passwordCheck({@required String? password}) async {
    ApiResponse? aux = await _professionalService.passwordCheck(
      email: user!.email,
      token: user!.token,
      password: password!,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return aux.response ? null : 'Senha incorreta!';
  }

  Future<String?> changePassword({@required String? password}) async {
    ApiResponse? aux = await _professionalService.changePassword(
      email: user!.email,
      token: user!.token,
      password: password!,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  Future<String?> forgotPassword({@required String? email}) async {
    ApiResponse? aux = await _professionalService.forgotPassword(
      email: user!.email,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  Future<String?> verifyNewPasswordCode({@required String? code}) async {
    ApiResponse? aux = await _professionalService.verifyNewPasswordCode(
      email: user!.email,
      code: code!,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return null;
  }

  Future<String?> updatePassword({@required String? password}) async {
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

  Future<String?> updateUser() async {
    ApiResponse? aux = await _professionalService.update(
      user: user!,
    );

    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    } else if (!aux.response) {
      return 'Ocorreu um erro inesperado';
    }

    return null;
  }

  Future<void> loadDataOnLoginSuccess() async {
    await getCourseInfo();
    await getInfoUser();

    getIndications();
    getMessage();
    getFiles();
  }

  Future<void> getInfoUser() async {
    ApiResponse? aux = await _professionalService.getInfo(email: user?.email, token: user?.token);
    if (aux!.isValid ?? false) {
      user!.copy(aux.response as User);
      notifyListeners();
    }
  }

  Future<void> getMessage() async {
    if (user == null) return;

    ApiResponse? aux = await _messageService.search(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    messages = aux.response as List<Message>;
    messages = messages.reversed.toList();
    notifyListeners();
  }

  Future<void> getIndications() async {
    if (user == null) return;

    ApiResponse? aux = await _indicationsService.search(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    indications = aux.response as List<Indication>;
    notifyListeners();
  }

  Future<void> readMessages() async {
    if (user == null) return;

    for (Message e in messages.where((element) => !element.messageRead!).toList()) {
      ApiResponse? value = await _messageService.readMessage(
        email: user!.email,
        token: user!.token,
        id: e.idMessage,
      );

      if (value!.response as bool) e.messageRead = true;
    }
    notifyListeners();
  }

  Future<void> viewIndication(Indication indication) async {
    if (user == null) return;

    _indicationsService.viewer(
      email: user!.email,
      token: user!.token,
      idIndication: indication.idIndications,
    );
  }

  Future<String?> sendIndication({
    @required String? toEmail,
    @required String? toName,
    @required Indication? indication,
  }) async {
    ApiResponse? aux = await _indicationsService.send(
      email: user!.email,
      token: user!.token,
      idIndication: indication!.idIndications,
      toEmail: toEmail,
      toName: toName,
    );
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    }

    return aux.response ? null : 'Ocorreu um erro ao enviar a indicação!';
  }

  Future<void> getCourseInfo() async {
    ApiResponse? aux = await _courseService.getInfo(user!.email!);
    if (aux!.isValid ?? false) {
      course = aux.response as Course;
      newCourse = course == null;

      aux = await _courseService.getYearReceipt(email: user!.email, token: user!.token);
      if ((aux!.isValid ?? false) && course != null) {
        course!.dateInclusionAndValidatedAdd(aux.response);
      }
    }
  }

  Future<void> getFiles({TagEnum? tag}) async {
    ApiResponse? aux = await _fileService.getFiles(
      tag: tag,
      email: user!.email,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    List<FileApp> files = aux.response as List<FileApp>;

    try {
      _provaDeVida = files
          .firstWhere(
            (element) => element.tag == TagEnum.lifeProof.getName,
          )
          .externalUrl;
    } catch (e) {}

    try {
      _boleto = files
          .firstWhere(
            (element) => element.tag == TagEnum.boleto.getName,
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
  }

  Future<String?> uploadFile(File file, TagEnum tag, {String? email}) async {
    ApiResponse? aux = await _uploadFileService.uploadFile(
      file: file,
      tag: tag,
      email: email ?? user!.email,
    );
    debugPrint('GERE $aux');
    if (!(aux!.isValid ?? false)) {
      return aux.errorMessage;
    } else if (!aux.response) {
      return 'Ocorreu um erro inesperado';
    }
    return aux.errorMessage;
  }

  Future<String?> saveCourse() async {
    ApiResponse? aux;
    if (newCourse!) {
      aux = await _courseService.saveCourse(
        course!,
        user!.email,
      );
    } else {
      aux = await _courseService.updateCourse(
        course!,
        user!.email,
      );
    }
    if (aux!.isValid ?? false) {
      if (aux.response as bool) {
        await getCourseInfo();
        return course != null ? null : 'Ocorreu um erro inesperado';
      }
    }
    return aux.errorMessage;
  }

  Future<ApiResponse?> generateBarCode(num value) async {
    ApiResponse? aux = await WalletService().generateBRCode(
      email: user!.email,
      token: user!.token,
      value: value,
    );
    return aux;
  }

  ///GET AND SETTERS

  dynamic get perfilPicture => _perfilPicture;

  set perfilPicture(dynamic value) {
    _perfilPicture = value;

    notifyListeners();
  }

  dynamic get boleto => _boleto;

  set boleto(dynamic value) {
    _boleto = value;
    notifyListeners();
  }

  dynamic get provaDeVida => _provaDeVida;

  set provaDeVida(dynamic value) {
    _provaDeVida = value;
    notifyListeners();
  }

  void logout() {
    newCourse = null;
    user = User();
    course = null;
    messages = [];
    _perfilPicture = null;
    _boleto = null;
    _provaDeVida = null;
  }
}
