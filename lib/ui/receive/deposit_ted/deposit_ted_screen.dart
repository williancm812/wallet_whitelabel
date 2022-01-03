import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/widget/line_client_information.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

import 'deposit_ted_functions.dart';

class DepositTedScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const DepositTedScreen({Key? key, this.onPrimaryTap}) : super(key: key);

  @override
  _DepositTedScreenState createState() => _DepositTedScreenState();
}

class _DepositTedScreenState extends State<DepositTedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppController().backgroundPay,
        body: body(),
      ),
    );
  }

  body() {
    return Column(
      children: [
        LineHigher(
          text: 'Depósito',
          image: 'assets/images/ic_deposit.svg',
          backgroundLineHigher: Colors.transparent,
          containerColor: AppController().backgroundSecondRodoPay,
          finalIcon: Icons.share,
          icon: Icons.close,
          onPrimaryTap: widget.onPrimaryTap,
          onFinalTap: () => onShareTed(context),
        ),

        SizedBox(height: getHeight(context, 0.08, 60)),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: getHeight(context, 0.098, 80)),
              textTop(),
              const SizedBox(height: 30),
              clientInformation()
            ],
          ),
        ),
      ],
    );
  }

  textTop() {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        text: 'Compartilhe os dados ',
        style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
            text: 'abaixo para receber em sua conta.',
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  clientInformation() {
    return Column(
      children: [
        LineClientInformation(
          text: 'Agência',
          value: context.watch<BankManager>().wallet!.branchCode!,
        ),
        const SizedBox(height: 20),
        LineClientInformation(
          text: 'Conta',
          value: context.watch<BankManager>().wallet!.formatWorkspace,
        ),
        const SizedBox(height: 20),
        LineClientInformation(
          text: 'CPF/CNPJ',
          value: context.watch<BankManager>().wallet!.taxId!,
        ),
        const SizedBox(height: 20),
        const LineClientInformation(
          text: 'Banco',
          value: 'Stark Bank',
        ),
        const SizedBox(height: 20),
        const LineClientInformation(
          text: 'Tipo',
          value: 'Conta de Pagamento',
        ),
        const SizedBox(height: 20),

      ],
    );
  }
}
