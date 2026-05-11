import 'package:career/core/constant/class/app_color.dart';
import 'package:flutter/material.dart';

class SettingAppearanceTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingAppearanceTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 40,
      leading: const Icon(
        Icons.light_mode_outlined,
        color: Colors.cyan,
        size: 22,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColor.secondryColor,
      ),
    );
  }
}