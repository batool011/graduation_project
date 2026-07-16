import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/constant/class/app_size.dart';
import 'package:career/core/network/token_storage.dart';
import 'package:career/core/router/routes_name.dart';
import 'package:career/core/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constant/class/app_string.dart';
import '../../../../core/widget/custom_app_bar.dart';
import '../getx/controller/setting_controller.dart';
import '../widget/custom_list_tile.dart';
import '../widget/setting_account_header.dart';
import '../widget/setting_appearance_tile.dart';
import '../widget/setting_section_divider.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 70),
        child: CustomAppBar(text: AppString.setting.tr),
      ),
      body: ListView(
        children: [
          SettingAccountHeader(
            accountSettingsLabel: AppString.accountSettings.tr,
          ),
          12.verticalSpace(),
          Container(
            height: .9.h(context),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.only(start: 0.05.w(context)),
              child: Column(
                children: [
                  Lottie.asset(AppAsset.setting, height: 250),
                  10.verticalSpace(),
                  CustomListTile(
                    leading: AppAsset.languageSetting,
                    title: AppString.language.tr,
                onTap: () {
  Get.defaultDialog(
    title: AppString.language.tr,
    content: Column(
      children: [
        ListTile(
          title: const Text('العربية'),
          onTap: () async {
            await TokenStorage.saveLanguage('ar');

            Get.updateLocale(
              const Locale('ar', 'AR'),
            );

            Get.back();
          },
        ),
        ListTile(
          title: const Text('English'),
          onTap: () async {
            await TokenStorage.saveLanguage('en');

            Get.updateLocale(
              const Locale('en', 'US'),
            );

            Get.back();
          },
        ),
      ],
    ),
  );
},
                  ),
                  const SettingSectionDivider(),
                  CustomListTile(
                    leading: AppAsset.helpSetting,
                    title: AppString.helpCenter.tr,
                    onTap: () {
                      Get.toNamed(RoutesName.helpCenter);
                    },
                  ),
                  const SettingSectionDivider(),
                  Obx(() {
                    final themeController = controller.themeController;
                    return SettingAppearanceTile(
                      title: AppString.appearance.tr,
                      value: themeController.isDarkMode,
                      onChanged: (_) => themeController.toggleTheme(),
                    );
                  }),
                  const SettingSectionDivider(),
                  CustomListTile(
                    leading: AppAsset.aboutUsSetting,
                    title: AppString.aboutUs.tr,
                    onTap: () {
                      Get.toNamed(RoutesName.aboutApp);
                    },
                  ),
                  const SettingSectionDivider(),
                  CustomListTile(
                    leading: AppAsset.logOutSetting,
                    title: AppString.logOut.tr,
                    onTap:
                        () => showCustomDialog(
                          context,
                          title: AppString.logoutConfirmationTitle.tr,
                          subtitle: AppString.logoutConfirmationMessage.tr,
                          image: Icon(
                            Icons.logout_rounded,
                            size: 42,
                            color: AppColor.primaryColor,
                          ),
                          confirmText: AppString.confirmLogout.tr,
                          cancelText: AppString.cancel.tr,
                          onConfirm: controller.logout,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
