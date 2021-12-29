

import 'package:intl/intl.dart';

class PixCreated {
  PixCreated();

  num? amount;
  num? created;
  num? due;
  String? brcode;
  String? pdf;

  String get formatDate {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch((due!.toInt() * 1000));
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  PixCreated.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] / 100.0;
    created = json['created'];
    due = json['due'];
    brcode = json['brcode'];
    pdf = json['pdf'];
  }

  @override
  String toString() {
    return 'BoletoCreated{amount: $amount, created: $created, due: $due, brcode: $brcode, pdf: $pdf}';
  }
}
