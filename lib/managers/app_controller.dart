import 'dart:ui';

class AppController {
  static final AppController _instance = AppController.internal();

  factory AppController() => _instance;

  AppController.internal();

  Color? errorColor = const Color(0xffEB5757);
  Color? desabilitedColor = const Color(0xffA4ABB3);
  Color? lineHigherColor = const Color(0xff002978);
  Color? lineHigherTextColor = const Color(0xffFFFFFF);
  Color? secondPrincipalColor = const Color(0xff1D86A6);
  Color? buttonConfig = const Color(0xff00004A);
  Color? buttonDesabilited = const Color(0xff5DB6D8);
  Color? lineContainerContactColor = const Color(0xff00004A);
  Color? lineContactColor = const Color(0xff5DB6D8);
  Color? colorInput = const Color(0xffFFFFFF);
  Color? containerHomeColor = const Color(0xff002978);
  Color? iconColorBlack = const Color(0xff000000);
  Color? backgroundRodoPay = const Color(0xffFFFFFF);
  Color? backgroundSecondRodoPay = const Color(0xff002978);
  Color? backgroundPay = const Color(0xff1D86A6);
  Color? blueLetterRodoPay = const Color(0xff1D86A6);
  Color? colorTextInput = const Color(0xff000000);
  Color? textBlack = const Color(0xff000000);
  Color? textWhite = const Color(0xffFFFFFF);
}
