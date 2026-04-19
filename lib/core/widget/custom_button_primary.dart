import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';
import '../constant/class/app_color.dart';

class CustomButtonPrimary extends StatelessWidget {
  const CustomButtonPrimary({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
  });
  final String text;
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 0.04.w(context),
          horizontal: 0.05.w(context),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 0.02.w(context),
          horizontal: 0.05.w(context),
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF5666AD), AppColor.primaryColor],
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child:
              isLoading
                  ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                    ),
                  )
                  : Text(text, style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    );
  }
}
