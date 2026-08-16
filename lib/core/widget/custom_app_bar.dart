import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:flutter/material.dart';

/// Shared top bar used across the app. Always shows a real, tappable back
/// button when there's somewhere to go back to (previously this bar had
/// no visible back affordance at all - navigation relied purely on the
/// OS back gesture/button, which is easy to miss). Pass [actions] for any
/// trailing icons a specific screen needs (e.g. a filter or clear button).
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.actions,
    this.showBackButton = true,
    this.onBackTap,
  });

  final String text;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    final canGoBack = showBackButton && Navigator.of(context).canPop();

    return SafeArea(
      bottom: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 0.018.h(context),
          horizontal: AppSpacing.sm,
        ),
        decoration: const BoxDecoration(color: AppColor.primaryColor),
        child: Row(
          children: [
            SizedBox(
              width: 44,
              child: canGoBack
                  ? IconButton(
                      onPressed: onBackTap ?? () => Navigator.of(context).maybePop(),
                      icon: const BackButtonIcon(),
                      color: AppColor.white,
                      splashRadius: 22,
                    )
                  : null,
            ),
            Expanded(
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(
              width: 44,
              child: (actions != null && actions!.isNotEmpty)
                  ? Row(mainAxisSize: MainAxisSize.min, children: actions!)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
