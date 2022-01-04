import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/transfer_manager.dart';

onShareRealizeTransfer(BuildContext context) async {
  String text;

  TransferManager manager = context.read<TransferManager>();
  BankManager bankManager = context.read<BankManager>();

  text = " Origem:"
      "\nNome: ${bankManager.user!.name}"
      "\nAgência: ${bankManager.wallet!.branchCode}"
      "\nConta: ${bankManager.wallet!.formatWorkspace}"
      "\n"
      "\nDestino:"
      "\nNome: ${manager.selectContact!.name}"
      "\nValor: R\$ ${manager.transferValue!.formatterToPtBr()}"
      "\nAgência: ${manager.selectContact!.branch}"
      "\nConta: ${formatWorkspace(manager.selectContact!.account!)}"
      "\n${manager.isCNPJ ? 'CNPJ' : 'CPF'}: ${formatCPForCNPJ(manager.selectContact!.document!)}"
      "\nMétodo: ${manager.selectContact!.methodTransfer}";

  shareText(text);
}
