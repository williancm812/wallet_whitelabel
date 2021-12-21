library wallet_whitelabel;
import 'package:intl/intl.dart';


// Map<String, dynamic> map = {
//   "accountNumber": "5821399314726912",
//   "amount": 500,
//   "branchCode": "0001",
//   "ispb": "20018183",
//   "name": "Br Programas Educacionais Ltda",
//   "status": "active",
//   "taxId": "34.686.091/0001-82",
// };
class BrCodePreview {
  BrCodePreview();

  String? brCode;
  String? accountNumber;
  num? amount;
  String? branchCode;
  String? ispb;
  String? name;
  String? status;
  String? taxId;


  BrCodePreview.fromJson(Map<String, dynamic> json) {
    accountNumber = json['accountNumber'] ;
    try{
      amount = json['amount'] / 100.0;
    } catch(e){
      amount = 0;
    }
    branchCode = json['branchCode'];
    ispb = json['ispb'];
    name = json['name'];
    status = json['status'];
    taxId = json['taxId'];
  }

  @override
  String toString() {
    return 'BrCodePreview{accountNumber: $accountNumber, amount: $amount, branchCode: $branchCode, ispb: $ispb, name: $name, status: $status, taxId: $taxId}';
  }
}
