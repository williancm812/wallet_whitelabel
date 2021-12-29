import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context, double percent, double max) {
  assert(percent <= 1 && percent > 0);
  double width = MediaQuery.of(context).size.width; //100% da tela

  return width * percent > max ? max : width * percent;
}

double getHeight(BuildContext context, double percent, double max) {
  assert(percent <= 1 && percent > 0);
  double height = MediaQuery.of(context).size.height; //100% da tela

  return height * percent > max ? max : height * percent;
}
