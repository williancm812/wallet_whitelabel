import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';

onSharePayPixSuccess(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();
  PixManager manager = context.read<PixManager>();

  text = "Pagador: ${bankManager.user!.name}"
      "\nValor: R\$ ${manager.brCodePreview!.amount!.formatterToPtBr()}"
      "\nPagamento com: Saldo em conta"
      "\nData de pagamento: ${manager.payingTimeDate}"
      "\nPara: ${manager.brCodePreview!.name}"
      "\nBanco: Stark Bank"
      "\nTipo: Código Pix";

  shareText(text);
}
