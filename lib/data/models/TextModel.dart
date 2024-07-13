import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textmodel {
  String content;
  GoogleFonts ?font;
  bool isUnderlined;
  bool isItalique;
  bool isBold;
  double fontSize;
  Textmodel({
    required this.content,
     this.font,
    required this.isUnderlined,
    required this.isItalique,
    required this.isBold,
    required this.fontSize,
  });

  factory Textmodel.fromEntity(Textmodel text) {
    return Textmodel(
        content: text.content,
        font: text.font,
        isUnderlined: text.isUnderlined,
        isItalique: text.isItalique,
        isBold: text.isBold,
        fontSize: text.fontSize);
  }

  Textmodel toEntity() {
    return Textmodel(
        content: content,
        font: font,
        isUnderlined: isUnderlined,
        isItalique: isItalique,
        isBold: isBold,
        fontSize: fontSize);
  }
 
     
  Widget toWidget(){
      return Text(content, style: TextStyle(fontSize: fontSize, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontStyle: isItalique ? FontStyle.italic : FontStyle.normal, decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none));
  }
    
}