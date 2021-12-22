import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supercharged/supercharged.dart';
import 'package:wallet_whitelabel/models/api_response.dart';
import 'package:wallet_whitelabel/models/contact.dart';
import 'package:wallet_whitelabel/models/extract_item.dart';
import 'package:wallet_whitelabel/models/ted_item.dart';
import 'package:wallet_whitelabel/models/user.dart';
import 'package:wallet_whitelabel/models/wallet.dart';
import 'package:wallet_whitelabel/services/contact_service.dart';
import 'package:wallet_whitelabel/services/extract_service.dart';
import 'package:wallet_whitelabel/services/ted_service.dart';
import 'package:wallet_whitelabel/services/wallet_service.dart';

class BankManager extends ChangeNotifier {
  final TedService _tedService = TedService();
  final WalletService _walletService = WalletService();
  final ExtractService _extractService = ExtractService();
  final ContactService _contactService = ContactService();

  bool initialLoad = false;
  User? user;
  List<TedItem> availableTeds = [];
  List<Contact> contacts = [];

  Wallet? wallet;

  List<ExtractGroupDay> extracts = [];

  List<Contact> get pixContacts => contacts
      .where(
        (element) => element.isInternal == 0,
      )
      .toList();

  Future<void> updateUser(User? user) async {
    this.user = user;
    if (user != null && initialLoad) return;
    initialLoad = true;
    // startTimer();
    loadWallet();
    getExtract();
    getAvailableTed();
    getContacts();
    return;
  }

  Future<void> loadWallet() async {
    ApiResponse? aux = await _walletService.wallet(email: user!.email, token: user!.token);
    if (!(aux!.isValid ?? false)) {
      return;
    }

    wallet = aux.response as Wallet;

    aux = await _walletService.balance(email: user!.email, token: user!.token);
    if (!(aux!.isValid ?? false)) {
      return;
    }

    wallet!.balance = aux.response as Balance;
    notifyListeners();
  }

  Future<void> getAvailableTed() async {
    if (user == null) return;

    ApiResponse? aux = await _tedService.listAvailableTed(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    availableTeds = aux.response as List<TedItem>;
  }

  Future<void> getContacts() async {
    if (user == null) return;

    ApiResponse? aux = await _contactService.listContancts(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    contacts = aux.response as List<Contact>;
    contacts.sort((a, b) => a.name!.compareTo(b.name!));
  }

  Future<void> getExtract() async {
    if (user == null) return;

    ApiResponse? aux = await _extractService.extractList(
      email: user!.email,
      token: user!.token,
    );
    if (!(aux!.isValid ?? false)) {
      return;
    }
    List<ExtractItem> list = aux.response as List<ExtractItem>;

    list.sort((a, b) => (a.created! > b.created!) ? 1 : 0);

    Map<String, dynamic> map = list.groupBy((element) => element.formatDate);

    extracts.clear();
    for (var element in map.keys) {
      ExtractGroupDay extractGroupDay = ExtractGroupDay();
      extractGroupDay.time = DateFormat("dd/MM/yyyy").parse(element);
      extractGroupDay.extracts = list.where((l) => l.formatDate == element).toList();

      extracts.add(extractGroupDay);
    }
    extracts = extracts.reversed.toList();

    for (var element in extracts) {
      element.extracts!.sort((a, b) => a.created! < b.created! ? 1 : 0);
      element.dayBalance = element.extracts!.first.balance;
      // element.extracts!.forEach(debugPrint);
    }
    notifyListeners();
  }

  void logout() {
    initialLoad = false;
    user = null;
    wallet = null;
    availableTeds = [];
    extracts = [];
  }
}
