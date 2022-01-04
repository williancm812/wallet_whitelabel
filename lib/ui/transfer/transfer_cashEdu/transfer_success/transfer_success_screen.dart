import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/formatter_utils.dart';
import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/transfer_manager.dart';
import 'package:wallet_whitelabel/ui/transfer/transfer_cashEdu/transfer_success/transfer_success_function.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class TransferSuccessScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const TransferSuccessScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _TransferSuccessScreenState createState() => _TransferSuccessScreenState();
}

class _TransferSuccessScreenState extends State<TransferSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppController().backgroundSecond,
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
                  text: 'Transferir',
                  icon: Icons.close,
                  finalIcon: Icons.share,
                  finalIconColor: Colors.white,
                  onPrimaryTap: widget.onPrimaryTap,
                  onFinalTap: () => onShareTransferSuccess(context),
                ),
                SizedBox(height: getHeight(context, 0.098, 80)),
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
          text: 'Tudo certo! ',
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' Você realizou uma transferência.',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  textOrigin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Origem',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  textDestiny() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Destino',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  containerOrigin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
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
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      context.watch<BankManager>().user!.name!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Agência',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      context.watch<BankManager>().wallet!.branchCode!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Conta',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      formatWorkspace(context.watch<BankManager>().wallet!.workspace!) ?? 'N/A',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  containerDestiny() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      context.watch<TransferManager>().selectContact!.name!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Valor',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'R\$ ${context.watch<TransferManager>().transferValue!.formatterToPtBr()}',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Agência',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      context.watch<TransferManager>().selectContact!.branch!,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Conta',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      formatWorkspace(context.watch<TransferManager>().selectContact!.account!) ?? 'N/A',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'CPF',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      formatCPF(context.watch<TransferManager>().selectContact!.document!) ?? 'N/A',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Método',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Transferência entre contas',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
              'Transferência realizada em ${context.watch<TransferManager>().payingTimeDate}'
              ' às ${context.watch<TransferManager>().payingTimeHour}',
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
