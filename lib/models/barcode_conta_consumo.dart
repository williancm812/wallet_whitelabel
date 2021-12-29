

import 'package:flutter/foundation.dart';
import 'package:wallet_whitelabel/common/date_utils.dart';
import 'package:wallet_whitelabel/common/string_extension.dart';

import 'barcode.dart';

enum SegmentContaConsumo {
  CITY_HALL,
  SANITATION,
  ENERGY,
  TELECOMS,
  GOV,
  OTHERS,
  FINE,
  UNDEFINED,
  RESERVED_BANK,
}

extension SegmentExtension on SegmentContaConsumo {
  String get name => describeEnum(this);

  String get getName {
    switch (this) {
      case SegmentContaConsumo.CITY_HALL:
        return 'Prefeitura';
      case SegmentContaConsumo.SANITATION:
        return 'Saneamento';
      case SegmentContaConsumo.ENERGY:
        return 'Energia Elétrica/Gás';
      case SegmentContaConsumo.TELECOMS:
        return 'Telecomunicações';
      case SegmentContaConsumo.GOV:
        return 'Órgão Governamental';
      case SegmentContaConsumo.OTHERS:
        return 'Carnes e Assemelhados ou demais Empresas';
      case SegmentContaConsumo.FINE:
        return 'Multa de trânsito';
      case SegmentContaConsumo.RESERVED_BANK:
        return 'Indefinido';
      case SegmentContaConsumo.UNDEFINED:
        return 'Uso exclusivo do banco';
      default:
        throw Exception();
    }
  }
}

class BarcodeContaConsumo extends BarcodeItem {
  String? rawValue;
  String? mask;
  bool? typed;

  String? bankName;

  String get validValue {
    if (typed!) {
      return rawValue!.substring(0, 11) +
          rawValue!.substring(12, 23) +
          rawValue!.substring(24, 35) +
          rawValue!.substring(36, 47);
    }
    return rawValue!;
  }

  BarcodeContaConsumo(this.rawValue) {
    debugPrint('CALL');
    if (rawValue == null || rawValue!.isEmpty) return;

    if (rawValue!.length == 44) {
      mask = MASK_SCANNED;
      typed = false;
    } else if (rawValue!.length == 48) {
      debugPrint('MASK TYPED $rawValue');
      mask = MASK_TYPED;
      typed = true;
    }
  }

  num? get getBankCode => null;

  int get getSegmentIndex {
    return int.parse(validValue[1]);
  }

  @override
  SegmentContaConsumo getSegment() {
    int ndx = getSegmentIndex;

    if (ndx < 1) ndx = 8;

    return SegmentContaConsumo.values[ndx - 1];
  }

  @override
  num get getAmount => num.parse(validValue.substring(4, 15)) / 100;

  DateTime? _testDueDate(String str) {
    int year = int.parse(str.substring(0, 4));

    int _testValue = (year - DateTime.now().year);
    _testValue = _testValue < 0 ? _testValue * -1 : _testValue;
    if (_testValue > 5) return null;

    int month = int.parse(str.substring(4, 6));
    int day = int.parse(str.substring(6));

    return DateTime(year, month - 1, day);
  }

  @override
  String get getDueDate {
    DateTime? date;
    if (getSegmentIndex == 9) {
      date = _testDueDate(validValue.substring(19, 27));
    } else {
      date = _testDueDate(validValue.substring(23, 31));

      date ??= _testDueDate(validValue.substring(19, 27));
    }
    return date == null ? '(não especificado)' : formatDate(date);
  }

  static bool isValid1(String value) {
    value = value.onlyNumber;
    return value.length == 44 || value.length == 48;
  }

  static bool isScannedValueValid1(String value) {
    value = value.onlyNumber;
    return value.length == 44;
  }

  String MASK_TYPED = "########### # ########### # ########### # ########### #";
  String MASK_SCANNED = "########### ########### ########### ###########";

  @override
  String toString() {
    return 'BarcodeContaConsumo{rawValue: $rawValue, mask: $mask, typed: $typed,'
        ' bankName: $bankName,'
        ' MASK_TYPED: $MASK_TYPED,'
        ' MASK_SCANNED: $MASK_SCANNED}';
  }
}
