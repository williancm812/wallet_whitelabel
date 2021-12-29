
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LineClientInformation extends StatelessWidget {
  final String? text;
  final String? value;
  final Color? textColor;
  final bool? expand;

  const LineClientInformation({
    Key? key,
    @required this.text,
    @required this.value,
    this.textColor = Colors.white,
    this.expand = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (expand!)
          Expanded(
            child: _buildText(),
          )
        else
          _buildText(),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value!,
            textAlign: TextAlign.end,
            style: GoogleFonts.roboto(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _buildText() {
    return Text(
      text!,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: 16,
      ),
    );
  }
}
