import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/common/share_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pay_manager.dart';
import 'package:wallet_whitelabel/models/barcode_boleto.dart';

onShareTicketGenerated(BuildContext context) async {
  String text;

  BankManager bankManager = context.read<BankManager>();
  PayManager payManager = context.read<PayManager>();

  text = "Dados bancarios:"
          "\nPagador: ${bankManager.user!.name}"
          "\nValor a ser pago: ${payManager.barcodeItem!.getAmount!.formatterToPtBr()}"
          "\nPagamento com: Saldo em conta"
          "\nData de Pagamento: ${payManager.payingTimeDate} ${payManager.payingTimeHour}"
          "\nVencimento: ${payManager.barcodeItem!.getDueDate}" +
      (payManager.barcodeItem is BarcodeBoleto
          ? "\nBanco: ${payManager.barcodeItem!.bankName}"
          : "\nSegmento: ${payManager.barcodeItem!.segmento}") +
      "\nCódigo de Barras: ${payManager.barcodeItem!.format()}";

  shareText(text);
}
