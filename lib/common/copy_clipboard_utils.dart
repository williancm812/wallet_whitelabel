import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_whitelabel/widget/snackbar_helper.dart';

Future<void> copyToClipboard({
  BuildContext? context,
  String? text,
  String? messagetext,
}) async {
  if (context == null || messagetext == null) return;

  Clipboard.setData(ClipboardData(text: text));
  showInSnackBar(
    context,
    messagetext,
    color: Colors.grey[700],
    fontSize: 18,
  );
}
