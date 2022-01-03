import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

onShareTed(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();

  text = "Dados bancarios:"
      "\nAgência: ${bankManager.wallet!.branchCode}"
      "\nConta: ${bankManager.wallet!.formatWorkspace}"
      "\nCPF/CNPJ: ${bankManager.wallet!.taxId}"
      "\nBanco: Stark Bank"
      "\nTipo: Conta de Pagamento";

  shareText(text);
}
