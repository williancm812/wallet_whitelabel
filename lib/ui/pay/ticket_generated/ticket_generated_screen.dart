

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/layouts/colors_utils.dart';
import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pay_manager.dart';
import 'package:wallet_whitelabel/models/barcode_conta_consumo.dart';
import 'package:wallet_whitelabel/ui/pay/ticket_generated/ticket_generated_functions.dart';
import 'package:wallet_whitelabel/widget/line_client_information.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class TicketGeneratedScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const TicketGeneratedScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _TicketGeneratedScreenState createState() => _TicketGeneratedScreenState();
}

class _TicketGeneratedScreenState extends State<TicketGeneratedScreen> {
  PayManager? manager;
  BankManager? bankManager;

  @override
  Widget build(BuildContext context) {
    manager = context.watch<PayManager>();
    bankManager = context.watch<BankManager>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundPay,
        body: body(),
      ),
    );
  }

  body() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LineHigher(
                  text: 'Pagar',
                  icon: Icons.close,
                  finalIcon: Icons.share,
                  backgroundLineHigher: Colors.transparent,
                  containerColor: backgroundSecondRodoPay,
                  finalIconColor: Colors.white,
                  onPrimaryTap: widget.onPrimaryTap,
                  onFinalTap: () => onShareTicketGenerated(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(context, 0.08, 70)),
                      textOrigin(),
                      const SizedBox(height: 10),
                      containerOrigin(),
                      const SizedBox(height: 20),
                      textDestiny(),
                      const SizedBox(height: 10),
                      containerDestiny(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        textBottom()
      ],
    );
  }

  textOrigin() {
    return Row(
      children: [
        Text(
          'Pagador',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        )
      ],
    );
  }

  textDestiny() {
    return Row(
      children: [
        Text(
          'Destino',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  containerOrigin() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            LineClientInformation(
              text: 'Nome',
              value: manager?.user?.name ?? '',
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
            LineClientInformation(
              text: 'Agência',
              value: bankManager?.wallet?.branchCode ?? '',
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
            LineClientInformation(
              text: 'Conta',
              value: bankManager?.wallet?.formatWorkspace ?? '',
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  containerDestiny() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const LineClientInformation(
              text: 'Data',
              value: 'Hoje',
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
            LineClientInformation(
              text: 'Vencimento',
              value: manager?.barcodeItem?.getDueDate ?? '',
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
            LineClientInformation(
              text: manager!.barcodeItem is BarcodeContaConsumo ? 'Segmento' : 'Banco',
              value: manager!.barcodeItem is BarcodeContaConsumo
                  ? manager!.barcodeItem!.getSegment()!.getName
                  : manager!.barcodeItem!.bankName!,
              textColor: blueLetterRodoPay,
            ),
            const SizedBox(height: 20),
            LineClientInformation(
              text: 'Código de barras',
              value: manager?.barcodeItem?.format() ?? '',
              textColor: blueLetterRodoPay,
            ),
          ],
        ),
      ),
    );
  }

  textBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Pagamento realizada em ${context.watch<PayManager>().payingTimeDate} '
              ' às ${context.watch<PayManager>().payingTimeHour}  ',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
