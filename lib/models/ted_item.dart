
// {"code":"406","name":"ACCREDITO SCD S.A."},
// {"ispb":"13140088","name":"ACESSO SOLUCOES PAGAMENTO SA"}

class TedItem {
  TedItem();
  String? code;
  String? name;
  String? ispb;

  TedItem.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  TedItem.fromPixJson(Map<String, dynamic> json) {
    ispb = json['ispb'];
    name = json['name'];
  }

  @override
  String toString() {
    return 'TedItem{code: $code, name: $name, ispb: $ispb}';
  }
}