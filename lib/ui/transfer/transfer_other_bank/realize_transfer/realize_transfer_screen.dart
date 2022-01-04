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
import 'package:wallet_whitelabel/ui/transfer/transfer_other_bank/realize_transfer/realize_transfer_function.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class RealizeTransferScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const RealizeTransferScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _RealizeTransferScreenState createState() => _RealizeTransferScreenState();
}

class _RealizeTransferScreenState extends State<RealizeTransferScreen> {
  TransferManager? manager;
  BankManager? bankManager;

  @override
  Widget build(BuildContext context) {
    manager = context.watch<TransferManager>();
    bankManager = context.watch<BankManager>();
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
                  text: 'Transferir',
                  icon: Icons.close,
                  finalIcon: Icons.share,
                  finalIconColor: Colors.white,
                  onPrimaryTap: widget.onPrimaryTap,
                  onFinalTap: () => onShareRealizeTransfer(context),
                ),
                SizedBox(height: getHeight(context, 0.07, 80)),
                textTop(),
                const SizedBox(height: 20),
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
          style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
              text: ' Você realizou uma transferência.',
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
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
            style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
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
            style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
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
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      manager!.user!.name!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                      bankManager!.wallet!.branchCode!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                      bankManager!.wallet!.formatWorkspace,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      manager!.selectContact!.name!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Valor',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'R\$ ${manager!.transferValue!.formatterToPtBr()}',
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Banco',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      manager!.selectContact!.bankName!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                      manager!.selectContact!.branch!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
                      formatWorkspace(manager!.selectContact!.account!) ?? 'N/A',
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    manager!.isCNPJ ? 'CNPJ' : 'CPF',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      formatCPForCNPJ(manager!.selectContact!.document!) ?? 'N/A',
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Método',
                    style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      manager!.selectContact!.methodTransfer!,
                      textAlign: TextAlign.end,
                      style:
                          GoogleFonts.roboto(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
