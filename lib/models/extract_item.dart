library wallet_whitelabel;
import 'package:intl/intl.dart';

class ExtractItem {
  ExtractItem();

  num? amount;
  num? balance;
  num? created;
  num? fee;
  String? text;
  String? type;

  num get positiveAmount {
    if (amount!.isNegative) return amount! * -1;
    return amount!;
  }

  bool get isOut => amount! < 0;

  String get formatDate {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch((created!.toInt() * 1000));
    dt.subtract(Duration(days: 1));
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  ExtractItem.fromJson(Map<String, dynamic> json) {
    // print(json);
    try{
      amount = json['amount'] / 100.0;
    } catch(e){
      print('amount');
    }
    try{
      balance = json['balance'] / 100.0;
    } catch(e){
      print('BALANCE');
    }
    try{
      fee = json['fee'] / 100.0;
    } catch(e){
      print('fee');
    }
    created = json['created'] as num;
    created = created!.toInt();
    text = json['text'];
    type = json['type'];
  }

  @override
  String toString() {
    return 'ExtractItem{amount: $amount, balance: $balance, created: $created, fee: $fee, text: $text, type: $type}';
  }
}

class ExtractGroupDay {
  DateTime? time;
  List<ExtractItem>? extracts = [];
  num? dayBalance;

  @override
  String toString() {
    return 'ExtractGroupDay{time: $time,'
        ' dayBalance: $dayBalance,'
        ' extracts: ${extracts!.length}}';
  }
}
