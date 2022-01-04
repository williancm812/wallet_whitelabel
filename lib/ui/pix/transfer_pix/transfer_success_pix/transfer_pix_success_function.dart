import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';

onShareTransferPixSuccess(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();
  PixManager manager = context.read<PixManager>();

  text = " Origem:"
      "\nNome: ${bankManager.user!.name}"
      "\nAgência: ${bankManager.wallet!.branchCode}"
      "\nConta: ${bankManager.wallet!.workspace}"
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
