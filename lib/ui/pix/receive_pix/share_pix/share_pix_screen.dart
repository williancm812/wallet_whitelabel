import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wallet_whitelabel/common/copy_clipboard_utils.dart';
import 'package:wallet_whitelabel/common/layouts/size_utils.dart';
import 'package:wallet_whitelabel/common/num_extension.dart';
import 'package:wallet_whitelabel/managers/app_controller.dart';
import 'package:wallet_whitelabel/managers/bank_manager.dart';
import 'package:wallet_whitelabel/managers/pix_manager.dart';
import 'package:wallet_whitelabel/ui/pix/receive_pix/share_pix/share_pix_function.dart';
import 'package:wallet_whitelabel/widget/line_higher.dart';

class SharePixScreen extends StatefulWidget {
  final num? value;
  final String? qrCode;
  final VoidCallback? onPrimaryTap;

  const SharePixScreen({
    Key? key,
    @required this.value,
    @required this.qrCode,
    @required this.onPrimaryTap,
  }) : super(key: key);

  @override
  _SharePixScreenState createState() => _SharePixScreenState();
}

class _SharePixScreenState extends State<SharePixScreen> {
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppController().backgroundSecond,
        resizeToAvoidBottomInset: false,
        body: body(),
      ),
    );
  }

  body() {
    return Column(
      children: [
        LineHigher(
          text: 'Receber Pix',
          image: 'assets/images/ic_pix_toolbar.svg',
          icon: Icons.close,
          finalIcon: Icons.share,
          backgroundLineHigher: AppController().backgroundSecond,
          onPrimaryTap: widget.onPrimaryTap,
          finalIconColor: Colors.white,
          onFinalTap: () => onShareReceiverPix(context),
        ),
        SizedBox(height: getHeight(context, 0.08, 70)),
        textTop(),
        SizedBox(height: getHeight(context, 0.098, 80)),
        qrcode(),
      ],
    );
  }

  textTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        text: TextSpan(
          text: 'O código pix de ',
          style: GoogleFonts.roboto(
            fontSize: 17,
            color: Colors.white,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'R\$ ${widget.value!.formatterToPtBr()} foi gerado',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ' com sucesso',
              style: GoogleFonts.roboto(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  qrcode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppController().secondPrincipalColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                color: Colors.white,
                width: 220 - 20.0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: QrImage(
                      data: widget.qrCode!,
                      version: QrVersions.auto,
                      size: 200 - 20.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  AutoSizeText(
                    "Valor",
                    maxFontSize: 20,
                    minFontSize: 17,
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: AutoSizeText(
                      "R\$ ${widget.value!.formatterToPtBr()}",
                      maxFontSize: 20,
                      minFontSize: 17,
                      textAlign: TextAlign.end,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Chave Pix",
                      maxFontSize: 17,
                      minFontSize: 10,
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: AutoSizeText(
                        context.watch<BankManager>().wallet?.idPix ?? 'Pix não carregado',
                        maxFontSize: 17,
                        minFontSize: 10,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  AutoSizeText(
                    "Código do Pix",
                    maxFontSize: 20,
                    minFontSize: 17,
                    style: GoogleFonts.openSans(color: Colors.white, fontSize: 18),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await copyToClipboard(
                        context: context,
                        text: context.read<PixManager>().pixCreated!.brcode ?? 'Pix não carregado',
                        messagetext: 'O código do Pix foi copiado para a área de transferência.',
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.copy,
                          color: Colors.white,
                        ),
                        AutoSizeText(
                          'Copiar',
                          maxFontSize: 20,
                          minFontSize: 17,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
}
