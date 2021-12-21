import 'package:intl/intl.dart';

import 'package:jiffy/jiffy.dart';

String getExtensionValue(DateTime dt) {
  String text;
  text = DateFormat(
    'EEEE, dd MMMM', 'pt_BR'
  ).format(dt);

  text = text.replaceAll(text.split(" ").last, "de " + text.split(" ").last);
  return text[0].toUpperCase() + text.substring(1);
}

String formatDate(DateTime dt, {String format = 'dd/MM/yyyy'}) {
  return DateFormat(format).format(dt);
}

DateTime? getDateFrom(String dt, {String format = 'dd/MM/yyyy'}) {
  try{
    return DateFormat(format).parse(dt);
  } catch(e){
    return null;
  }
}

DateTime addMouths(DateTime dt, int mouths) {
  //return getFormatDate(Jiffy().add(months: mouths));
  return (Jiffy()..add(months: mouths)).dateTime;
}
