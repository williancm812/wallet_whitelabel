import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';
import 'package:wallet_whitelabel/ui/pix/pay_pix/pay_pix_success/pay_pix_success_function.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class PayPixSuccessScreen extends StatefulWidget {
  final VoidCallback? onPrimaryTap;

  const PayPixSuccessScreen({
    Key? key,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _PayPixSuccessScreenState createState() => _PayPixSuccessScreenState();
}

class _PayPixSuccessScreenState extends State<PayPixSuccessScreen> {
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
                  text: 'Pagamento pix',
                  image: 'assets/images/ic_pix_toolbar.svg',
                  icon: Icons.close,
                  finalIcon: Icons.share,
                  finalIconColor: Colors.white,
                  onPrimaryTap: widget.onPrimaryTap,
                  onFinalTap: () => onSharePayPixSuccess(context),
                ),
                const SizedBox(height: 80),
                textTop(),
                const SizedBox(height: 20),
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
          text: 'Tudo certo!',
          style: GoogleFonts.roboto(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          children: <TextSpan>[
            TextSpan(
              text: ' Você acaba de pagar seu código com sucesso.',
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

  containerDestiny() {
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
              _line('Pagador', '${context.watch<BankManager>().user!.name}'),
              const SizedBox(height: 20),
              _line('Valor', '${context.watch<PixManager>().brCodePreview!.amount!.formatterToPtBr()}'),
              const SizedBox(height: 20),
              _line('Pagamento com ', 'Saldo em conta'),
              const SizedBox(height: 20),
              _line('Data de Pagamento', context.watch<PixManager>().payingTimeDate),
              const SizedBox(height: 20),
              _line('Para', '${context.watch<PixManager>().brCodePreview!.name}'),
              const SizedBox(height: 20),
              _line('Banco', 'Stark Bank'),
              const SizedBox(height: 20),
              _line('Tipo', 'Código Pix'),
            ],
          ),
        ),
      ),
    );
  }

  textBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Transferência realizada em ${context.watch<PixManager>().payingTimeDate}'
              ' às ${context.watch<PixManager>().payingTimeHour}',
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
