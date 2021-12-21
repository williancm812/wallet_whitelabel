import 'package:intl/intl.dart';


extension NumExtension on num {
  String? formatterToPtBr() {
    final oCcy =  NumberFormat("#,##0.00", "pt_BR");
    if (this != null)
      return oCcy.format(this);
    else
      return null;
  }
}