import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/network/token_storage.dart';
import 'package:career/core/widget/under_line_text.dart';
import 'package:flutter/material.dart';

class SettingAccountHeader extends StatelessWidget {
  final String accountSettingsLabel;

  const SettingAccountHeader({
    super.key,
    required this.accountSettingsLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05.w(context),
        vertical: 0.02.h(context),
      ),
      child: Row(
        children: [
          FutureBuilder<String?>(
            future: TokenStorage.getUserName(),
            builder: (context, snapshot) {
              final name = (snapshot.data ?? '').trim();
              return Text(
                name.isNotEmpty ? name : 'User',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          const Spacer(),
          UnderLineText(text: accountSettingsLabel),
        ],
      ),
    );
  }
}