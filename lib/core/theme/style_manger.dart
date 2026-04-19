import 'package:flutter/material.dart';
import 'font_constants.dart';

// String getFontFamily() {
//   final languageController = Get.find<LanguageController>();
//   return languageController.currentLang.value == 'ar'
//       ? 'ArabicFont'
//       : 'EnglishFont';
// }

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    fontFamily: 'Outfit',
    height: 1.2,
  );
}

TextStyle getRegularStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.regular, color);
}

TextStyle getLightStyle({double fontSize = 14, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.light, color);
}

TextStyle getBoldStyle({double fontSize = 18, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.bold, color);
}

TextStyle getMediumStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.medium, color);
}

TextStyle getSemiBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManger.semiBold, color);
}
