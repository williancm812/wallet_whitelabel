library wallet_whitelabel;

import 'package:supercharged/supercharged.dart';

class Wallet {
  Wallet();

  num? accountCreated;
  String? branchCode;
  String? idPix;
  String? ispb;
  String? masterName;
  String? ownerName;
  String? taxId;
  String? workspace;

  Balance? balance;

  String get formatWorkspace {
    if (workspace!.length == 16) {
      List<String> ws = workspace!.split("");

      String finalText = '';
      ws.chunked(4).forEach((element) {
        for (var e in element) {
          finalText += e;
        }
        finalText += '-';
      });
      return finalText.substring(0, 19);
    }
    return 'N/A';
  }

  Wallet.fromJson(Map<String, dynamic> json) {
    accountCreated = json['accountCreated'];
    branchCode = json['branchCode'];
    idPix = json['idPix'];
    ispb = json['ispb'];
    masterName = json['masterName'];
    ownerName = json['ownerName'];
    taxId = json['taxId'];
    workspace = json['workspace'];
  }

  Map<String, dynamic> toJson() => {
        "accountCreated": accountCreated,
        "branchCode": branchCode,
        "idPix": idPix,
        "ispb": ispb,
        "masterName": masterName,
        "ownerName": ownerName,
        "taxId": taxId,
        "workspace": workspace,
      };

  @override
  String toString() {
    return 'Wallet{accountCreated: $accountCreated, branchCode: $branchCode,'
        '\n idPix: $idPix, ispb: $ispb, masterName: $masterName,'
        '\n ownerName: $ownerName, taxId: $taxId, workspace: $workspace'
        '\n balance: $balance}';
  }
}

class Balance {
  Balance();

  num? amount;
  num? cashbackAmount;
  String? currency;
  String? id;
  num? result;
  num? updated;

  Balance.fromJson(Map<String, dynamic> json) {
    /// amount e cash dividir por 100
    amount = json['amount'] / 100;
    // amount = 123456.0;
    cashbackAmount = json['cashbackAmount'] / 100;
    currency = json['currency'];
    id = json['id'];
    result = json['result'];
    updated = json['updated'];
  }

  @override
  String toString() {
    return 'Balance{amount: $amount, cashbackAmount: $cashbackAmount,'
        ' currency: $currency, id: $id, result: $result, updated: $updated}';
  }
}
