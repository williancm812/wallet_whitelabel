library wallet_whitelabel;

import 'package:intl/intl.dart';

class BoletoCreated {
  BoletoCreated();

  num? amount;
  num? created;
  num? due;
  String? line;

  String get formatDate {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch((due!.toInt() * 1000));
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  BoletoCreated.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] / 100.0;
    created = json['created'];
    due = json['due'];
    line = json['line'];
  }

  @override
  String toString() {
    return 'BoletoCreated{amount: $amount, created: $created, due: $due, line: $line}';
  }
}
