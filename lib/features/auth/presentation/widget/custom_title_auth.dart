import 'package:flutter/material.dart';

class CustomTitleAuth extends StatelessWidget {
  const CustomTitleAuth({super.key, required this.text1, required this.text2});
final String text1;
final String text2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            text1 ,
            style:Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900)
        ),
        Text(
            text2,
            style:Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w900)
        ),
      ],
    );
  }
}
