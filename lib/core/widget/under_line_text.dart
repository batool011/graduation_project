import 'package:flutter/cupertino.dart';

import '../constant/class/app_color.dart';

class UnderLineText extends StatelessWidget {
  const UnderLineText({super.key, required this.text, this.onTap});
final String text;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontSize: 12,
          color: AppColor.secondryColor,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationThickness: 1,
          decorationColor: AppColor.secondryColor,
        ),
      ),
    );
  }
}
