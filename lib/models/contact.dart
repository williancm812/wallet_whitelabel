// {"code":"406","name":"ACCREDITO SCD S.A."},

class Contact {
  Contact();

  String? email;
  String? name;
  String? document;
  int? isInternal;
  String? bankCode;
  String? ispb;
  String? bankName;
  String? branch;
  String? account;
  String? methodTransfer;

  Contact.fromSearch(Map<String, dynamic> json) {
    document = json['cpf'];
    email = json['email'];
    name = json['name'];
    account = json['workspace'];
    branch = '0001';
    methodTransfer = 'Transferência entre contas';
  }

  Contact.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    document = json['document'];
    isInternal = json['internalAccount'];
    bankCode = json['bankCode'];
    ispb = json['ispb'];
    bankName = json['bankName'];
    branch = json['branch'];
    account = json['account'];
    methodTransfer = isInternal == 1 ? 'Transferência entre contas' : 'Transferência entre bancos';
  }

  @override
  String toString() {
    return 'Contact{email: $email, name: $name, document: $document,'
        '\n isInternal: $isInternal, bankCode: $bankCode, ispb: $ispb,'
        '\n bankName: $bankName, branch: $branch,'
        '\n account: $account, methodTransfer: $methodTransfer}';
  }
}
