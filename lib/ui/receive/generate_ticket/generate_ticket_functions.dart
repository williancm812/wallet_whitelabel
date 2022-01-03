import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/receive_manager.dart';

onShareBoleto(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();
  ReceiveManager receiveManager = context.read<ReceiveManager>();

  text = "Origem: "
      "\nNome: ${bankManager.user!.name}"
      "\nAgência: ${bankManager.wallet!.branchCode}"
      "\nConta: ${bankManager.wallet!.formatWorkspace}"
      "\n"
      "\nBoleto de pagamento:"
      "\nValor: R\$ ${receiveManager.boleto!.amount!.formatterToPtBr()}"
      "\nVencimento: ${receiveManager.boleto!.formatDate}"
      "\nLinha digitável: ${receiveManager.boleto!.line}";

  shareText(text);
}
