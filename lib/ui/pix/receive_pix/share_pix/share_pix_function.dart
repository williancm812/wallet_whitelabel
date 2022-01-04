import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';

onShareReceiverPix(BuildContext context) async {
  String text;

  PixManager manager = context.read<PixManager>();

  text = "O código Pix de R\$ ${manager.transferValue!.formatterToPtBr()} foi gerado com sucesso.:"
      "\nCódigo do Pix: ${manager.pixCreated!.brcode}"
      "\nQR code em formato .pdf: ${manager.pixCreated!.pdf}";

  shareText(text);
}
