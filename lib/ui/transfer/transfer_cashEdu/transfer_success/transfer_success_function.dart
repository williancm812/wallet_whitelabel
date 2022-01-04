import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common//num_extension.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/transfer_manager.dart';

onShareTransferSuccess(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();
  TransferManager transferManager = context.read<TransferManager>();

  text = " Origem:"
      "\nNome: ${bankManager.user!.name}"
      "\nAgência: ${bankManager.wallet!.branchCode}"
      "\nConta: ${bankManager.wallet!.workspace}"
      "\n"
      "\nDestino:"
      "\nNome: ${transferManager.selectContact!.name}"
      "\nValor: R\$ ${transferManager.transferValue!.formatterToPtBr()}"
      "\nAgência: ${transferManager.selectContact!.branch}"
      "\nConta: ${formatWorkspace(transferManager.selectContact!.account!)}"
      "\n${transferManager.isCNPJ ? 'CNPJ' : 'CPF'}: ${formatCPForCNPJ(transferManager.selectContact!.document!)}"
      "\nMétodo: ${transferManager.selectContact!.methodTransfer!}";

  shareText(text);
}
