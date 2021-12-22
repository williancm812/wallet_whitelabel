import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/br_code_preview.dart';
import 'package:wallet_whitelabel/models/contact.dart';
import 'package:wallet_whitelabel/models/pix_created.dart';
import 'package:wallet_whitelabel/models/ted_item.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/pix_service.dart';
import 'package:wallet_whitelabel/services/ted_service.dart';
import 'package:wallet_whitelabel/services/transfer_service.dart';

class PixManager extends ChangeNotifier {
  final PixService _pixService = PixService();
  final TedService _tedService = TedService();
  final TransferService _transferService = TransferService();

  User? user;
  bool initialLoad = false;

  PixCreated? pixCreated;
  BrCodePreview? brCodePreview;

  Contact? selectContact = Contact();
  List<TedItem> availableTeds = [];
  num? transferValue;

  num? payingTime;

  bool get isCNPJ => (selectContact?.document?.length ?? 0) > 11;

  String get payingTimeDate =>
      DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(payingTime!.toInt() * 1000));

  String get payingTimeHour =>
      DateFormat("HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(payingTime!.toInt() * 1000));

  Future<void> updateUser(User? user) async {
    this.user = user;
    if (user != null && initialLoad) return;
    initialLoad = true;
    getAvailablePixTed();
    return;
  }

  Future<String?> createTransfer() async {
    ApiResponse? aux = await _transferService.createTransfer(
      email: user!.email,
      token: user!.token,
      amount: (transferValue! * 100).toInt(),
      isPix: true,
      ispb: selectContact!.ispb,
      taxId: selectContact!.document,
      bankCode: selectContact!.bankCode,
      branchCode: selectContact!.branch,
      accountNumber: selectContact!.account,
      name: selectContact!.name,
      saveContact: false,
    );
    if (aux!.isValid ?? false) {
      payingTime = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> receivePix() async {
    ApiResponse? aux = await _pixService.receivePix(
      email: user!.email,
      token: user!.token,
      amount: (transferValue! * 100).toInt(),
      name: user!.name,
      taxId: formatCPForCNPJ(user!.cpf!),
    );
    if (aux!.isValid ?? false) {
      pixCreated = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> getBrCodePreview(String brCode) async {
    ApiResponse? aux = await _pixService.brCodePreview(
      email: user!.email,
      token: user!.token,
      brCode: brCode,
    );
    if (aux!.isValid ?? false) {
      brCodePreview = aux.response;
      brCodePreview!.brCode = brCode;
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> payPix() async {
    ApiResponse? aux = await _pixService.payPix(
      email: user!.email,
      token: user!.token,
      amount: (brCodePreview!.amount! * 100).toInt(),
      brCode: brCodePreview!.brCode,
      taxId: brCodePreview!.taxId!,
    );
    if (aux!.isValid ?? false) {
      payingTime = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  Future<void> getAvailablePixTed() async {
    if (user == null) return;

    ApiResponse? aux = await _tedService.listAvailablePix(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    availableTeds = aux.response as List<TedItem>;
  }

  void logout() {
    initialLoad = false;
    user = null;
    payingTime = null;
    selectContact = Contact();
    availableTeds = [];
    pixCreated = null;
    brCodePreview = null;
    transferValue = null;
  }
}
