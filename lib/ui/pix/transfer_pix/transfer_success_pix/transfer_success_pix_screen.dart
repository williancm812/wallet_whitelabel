import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';
import 'package:wallet_whitelabel/ui/pix/transfer_pix/transfer_success_pix/transfer_pix_success_function.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class TransferSuccessPixScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const TransferSuccessPixScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _TransferSuccessPixScreenState createState() => _TransferSuccessPixScreenState();
}

class _TransferSuccessPixScreenState extends State<TransferSuccessPixScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppController().backgroundSecondRodoPay,
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
                  text: 'Transferência pix',
                  icon: Icons.close,
                  finalIcon: Icons.share,
                  finalIconColor: Colors.white,
                  onPrimaryTap: widget.onPrimaryTap,
                  onFinalTap: () => onShareTransferPixSuccess(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: getHeight(context, 0.08, 80)),
                      textTop(),
                      const SizedBox(height: 20),
                      textOrigin(),
                      const SizedBox(height: 10),
                      containerOrigin(),
                      const SizedBox(height: 20),
                      textDestiny(),
                      const SizedBox(height: 10),
                      containerDestiny()
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

  textTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          text: 'Tudo certo!',
          style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: 'Você realizou uma transferência Pix.',
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  textOrigin() {
    return Row(
      children: [
        Text(
          'Origem',
          style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        )
      ],
    );
  }

  textDestiny() {
    return Row(
      children: [
        Text(
          'Destino',
          style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  containerOrigin() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppController().secondPrincipalColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Nome',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.watch<BankManager>().user!.name!,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Agência',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    context.watch<BankManager>().wallet!.branchCode!,
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Conta',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    formatWorkspace(context.watch<BankManager>().wallet!.workspace!) ?? 'N/A',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  containerDestiny() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppController().secondPrincipalColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            _line('Nome', '${context.watch<PixManager>().selectContact!.name}'),
            const SizedBox(height: 20),
            _line('Valor', '${context.watch<PixManager>().transferValue!.formatterToPtBr()}'),
            const SizedBox(height: 20),
            _line('Agência', '${context.watch<PixManager>().selectContact!.branch}'),
            const SizedBox(height: 20),
            _line('Conta', '${context.watch<PixManager>().selectContact!.account}'),
            const SizedBox(height: 20),
            _line(
              context.watch<PixManager>().isCNPJ ? 'CNPJ' : 'CPF',
              '${formatCPForCNPJ(context.watch<PixManager>().selectContact!.document!)}',
            ),
            const SizedBox(height: 20),
            _line('Banco', '${context.watch<PixManager>().selectContact!.bankName}'),
            const SizedBox(height: 20),
            _line('Método', '${context.watch<PixManager>().selectContact!.methodTransfer}'),
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
              'Transferência realizada em ${context.watch<PixManager>().payingTimeDate}'
              ' às ${context.watch<PixManager>().payingTimeHour}',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  _line(String text, String value) {
    return Row(
      children: [
        Text(
          text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
