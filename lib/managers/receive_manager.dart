import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/boleto_created.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/boleto_service.dart';
import 'package:flutter/material.dart';

class ReceiveManager extends ChangeNotifier {
  final BoletoService _boletoService = BoletoService();

  bool initialLoad = false;
  User? user;

  BoletoCreated? boleto;

  Future<void> updateUser(User? user) async {
    this.user = user;
    if (user != null && initialLoad) return;
    initialLoad = true;
    return;
  }

  Future<String?> createBoleto(num? amount) async {
    ApiResponse? aux = await _boletoService.createBoleto(
      email: user!.email,
      token: user!.token,
      amount: amount!.toInt(),
    );
    if (aux!.isValid ?? false) {
      boleto = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  void logout() {
    initialLoad = false;
    user = null;
    boleto = null;
  }
}
