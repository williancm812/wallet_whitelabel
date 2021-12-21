library wallet_whitelabel;

import 'package:wallet_whitelabel/common/date_utils.dart';
import 'package:wallet_whitelabel/common/string_extension.dart';
import 'package:wallet_whitelabel/models/barcode.dart';

class BarcodeBoleto extends BarcodeItem {
  BarcodeBoleto(String rawValue) {
    this.rawValue = rawValue;
    if (rawValue == null || rawValue.isEmpty) return;

    if (rawValue.length == 44) {
      mask = MASK_SCANNED;
      typed = false;
    } else if (rawValue.length == 47) {
      mask = MASK_TYPED;
      typed = true;
    }
  }

  @override
  num get getBankCode => num.parse(rawValue!.substring(0, 3));

  @override
  num get getAmount => num.parse(typed! ? rawValue!.substring(37) : rawValue!.substring(9, 19)) / 100;

  @override
  String get getDueDate {
    num dueFactor = num.parse(typed! ? rawValue!.substring(33, 37) : rawValue!.substring(5, 9));
    DateTime dateTime = DateTime(1997, 10, (7 + dueFactor.toInt()));
    // dateTime = dateTime.add(Duration(days: dueFactor));
    return formatDate(dateTime);
  }

  static bool isValid1(String value) {
    value = value.onlyNumber;
    return value.length == 44 || value.length == 47;
  }

  static bool isScannedValueValid1(String value) => value.length == 44;

  static String MASK_TYPED = "#####.##### #####.###### #####.###### # ##############";
  static String MASK_SCANNED = "#####.#### #####.##### #####.##### # ##############";
}
