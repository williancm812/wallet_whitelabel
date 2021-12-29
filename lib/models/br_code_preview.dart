

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
    accountNumber = json['accountNumber'];
    try {
      amount = json['amount'] / 100.0;
    } catch (e) {
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
