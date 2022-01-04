import 'package:wallet_whitelabel/common/copy_clipboard_utils.dart';
import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/receive_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

import 'generate_ticket_functions.dart';

class GenerateTicketScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const GenerateTicketScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _GenerateTicketScreenState createState() => _GenerateTicketScreenState();
}

class _GenerateTicketScreenState extends State<GenerateTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppController().backgroundThird,
        body: body(),
      ),
    );
  }

  body() {
    return Column(
      children: [
        LineHigher(
          text: 'Boleto',
          finalIcon: Icons.share,
          backgroundLineHigher: Colors.transparent,
          containerColor: AppController().backgroundSecond,
          icon: Icons.close,
          onPrimaryTap: widget.onPrimaryTap,
          onFinalTap: () {
            onShareBoleto(context);
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: getHeight(context, 0.098, 80)),
              textTop(),
              const SizedBox(height: 30),
              containerTicket(),
              const SizedBox(height: 10),
              lastText()
            ],
          ),
        ),
      ],
    );
  }

  textTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          text: 'Seu boleto de ',
          style: GoogleFonts.roboto(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'R\$'
                  ' ${(context.watch<ReceiveManager>().boleto!.amount!.formatterToPtBr())}'
                  ' foi gerado ',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'com sucesso, o vencimento  será em'
                  ' ${context.watch<ReceiveManager>().boleto!.formatDate}',
              style: GoogleFonts.roboto(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  containerTicket() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    await copyToClipboard(
                        context: context,
                        text: context.read<ReceiveManager>().boleto?.line ?? '',
                        messagetext: 'O código do boleto foi copiado para a área de transferência.');
                  },
                  child: Icon(
                    Icons.copy_outlined,
                    size: 22,
                    color: AppController().textBlack,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                context.watch<ReceiveManager>().boleto!.line!,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: AppController().textBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  lastText() {
    return Text(
      "Utilize o código acima para realizar seu depósito. Lembrando que "
      "transações via boleto, podem levar até 3 dias úteis para compensar "
      "o valor em sua conta após o pagamento.",
      style: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
