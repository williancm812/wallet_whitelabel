import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/contact.dart';
import 'package:wallet_whitelabel/models/ted_item.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/services/contact_service.dart';
import 'package:wallet_whitelabel/services/transfer_service.dart';

class TransferManager extends ChangeNotifier {
  final ContactService _contactService = ContactService();
  final TransferService _transferService = TransferService();

  User? user;
  bool initialLoad = false;

  List<TedItem> availableTeds = [];
  Contact? selectContact = Contact();
  bool? saveContact;

  bool get isCNPJ => selectContact!.document!.length > 11;
  num? transferValue;

  num? payingTime;

  String get payingTimeDate =>
      DateFormat("dd/MM/yyyy").format(DateTime.fromMillisecondsSinceEpoch(payingTime!.toInt() * 1000));

  String get payingTimeHour =>
      DateFormat("HH:mm:ss").format(DateTime.fromMillisecondsSinceEpoch(payingTime!.toInt() * 1000));

  Future<void> updateUser(User? user) async {
    debugPrint('CALL HERE');
    this.user = user;
    // debugPrint("BankManager User => " + user.toString());
    // debugPrint("BankManager initialLoad => " + initialLoad.toString());
    if (user != null && initialLoad) return;
    initialLoad = true;
    return;
  }

  Future<String?> createTransaction() async {
    ApiResponse? aux = await _transferService.createTransaction(
      email: user!.email,
      token: user!.token,
      amount: (transferValue! * 100).toInt(),
      receiverId: selectContact!.account,
    );
    if (aux!.isValid ?? false) {
      payingTime = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> createTransfer() async {
    ApiResponse? aux = await _transferService.createTransfer(
      email: user!.email,
      token: user!.token,
      amount: (transferValue! * 100).toInt(),
      isPix: false,
      taxId: selectContact!.document,
      bankCode: selectContact!.bankCode,
      branchCode: selectContact!.branch,
      accountNumber: selectContact!.account,
      name: selectContact!.name,
      saveContact: saveContact ?? false,
    );
    if (aux!.isValid ?? false) {
      payingTime = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  Future<String?> searchContact(String key, String type) async {
    ApiResponse? aux = await _contactService.searchUser(
      email: user!.email,
      token: user!.token,
      key: key,
      type: type,
    );
    if (aux!.isValid ?? false) {
      selectContact = aux.response;
      return null;
    }
    return aux.errorMessage;
  }

  void logout() {
    initialLoad = false;
    payingTime = null;
    user = null;
    availableTeds = [];
    transferValue = null;
  }
}
