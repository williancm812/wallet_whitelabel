import 'package:wallet_whitelabel/models/barcode/barcode_boleto.dart';
import 'package:wallet_whitelabel/models/barcode/barcode_conta_consumo.dart';
import 'package:wallet_whitelabel/common/extensions/string_extension.dart';


abstract class BarcodeItem {
  String? rawValue;
  String? mask;
  bool? typed;

  String? bankName;

  num? get getBankCode;

  num? get getAmount;

  String? get getDueDate;

  SegmentContaConsumo? getSegment() => null;

  String get segmento => getSegment()!.getName;

  bool isValid(String value) {
    if (value == null || value.isEmpty) return false;

    String line = value.onlyNumber;
    return BarcodeBoleto.isValid1(line) || BarcodeContaConsumo.isValid1(line);
  }

  bool isScannedValueValid(String value) {
    if (value.isEmpty) return false;

    String line = value.onlyNumber;
    return BarcodeBoleto.isScannedValueValid1(line) || BarcodeContaConsumo.isScannedValueValid1(line);
  }

  String format() {
    String format = "";

    int i = 0;
    List<String> chars = rawValue!.split("");

    for (String e in mask!.split("")) {
      if (e == '#') {
        format += chars[i];
        i++;
      } else {
        format += e;
      }
    }

    print("FORMAT VALUE = > " + format);
    return format;
  }
}
