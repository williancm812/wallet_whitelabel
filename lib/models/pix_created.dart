import 'package:intl/intl.dart';


// {"amount":15000,
// "brcode":"00020101021226890014br.gov.bcb.pix2567invoice-h.sandbox.starkbank.com/v2/f709f6d9d12d497b9d"
//      "00fa2861f545855204000053039865802BR5925Br Programas Educacionais6009Sao Paulo62070503***6304E090",
// "created":1637034389.897605,
// "due":1637207189.897005,
// "invoiceCreated":1,
// "pdf":"https://invoice-h.sandbox.starkbank.com/pdf/f709f6d9d12d497b9d00fa2861f54585"}
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
