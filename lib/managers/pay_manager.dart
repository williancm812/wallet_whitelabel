import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/barcode.dart';
import 'package:wallet_whitelabel/models/barcode_boleto.dart';
import 'package:wallet_whitelabel/models/boleto_created.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/boleto_service.dart';

class PayManager extends ChangeNotifier {
  final BoletoService _boletoService = BoletoService();

  bool initialLoad = false;

  BarcodeItem? barcodeItem;
  num? _payingTime;
  User? user;
  BoletoCreated? boleto;

  String get payingTimeDate =>
      DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(_payingTime!.toInt() * 1000));

  String get payingTimeHour =>
      DateFormat("HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(_payingTime!.toInt() * 1000));

  Future<void> updateUser(User? user) async {
    this.user = user;
    if (user != null && initialLoad) return;
    initialLoad = true;
    return;
  }

  Future<String?> payingBarcode(String taxId) async {
    ApiResponse? aux;
    if (barcodeItem is BarcodeBoleto) {
      aux = await _boletoService.payingBoleto(
        email: user?.email,
        token: user?.token,
        line: barcodeItem?.rawValue,
        taxId: taxId,
        typed: barcodeItem!.typed,
      );
    } else {
      aux = await _boletoService.payingContaConsumo(
        email: user?.email,
        token: user?.token,
        line: barcodeItem?.rawValue,
        typed: barcodeItem!.typed,
      );
    }
    if (aux!.isValid ?? false) {
      _payingTime = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  void logout() {
    initialLoad = false;
    user = null;
    _payingTime = null;
    boleto = null;
    barcodeItem = null;
  }
}
