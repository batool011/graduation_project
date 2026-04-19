import 'package:career/core/constant/class/app_color.dart';
import 'package:career/core/theme/theme_controller.dart';
import 'package:career/features/profile/presentation/screens/profile_screen.dart';
import 'package:career/features/setting/presentation/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../home/presentation/screen/home_screen.dart';
import '../../../saving_money/presentation/screens/saving_money_cards_screen.dart';


class MainScreen extends StatelessWidget {

  final PersistentTabController persistentController =
  PersistentTabController(initialIndex: 0);

  MainScreen({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      SavingsCardsScreen(),
      SettingScreen(),
      ProfileScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon:Icon(Icons.home_outlined,size: 30,color: AppColor.primaryColor,),
        inactiveIcon:Icon(Icons.home_outlined,size: 25,color: AppColor.blackLight,),
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.savings_outlined,size: 30,color: AppColor.primaryColor,),
        inactiveIcon:Icon(Icons.savings_outlined,size: 25,color: AppColor.blackLight,),
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.settings,size: 30,color: AppColor.primaryColor,),
        inactiveIcon:Icon(Icons.settings,size: 25,color: AppColor.blackLight,),
      ),
      PersistentBottomNavBarItem(
        icon:Icon(Icons.person,size: 30,color: AppColor.primaryColor,),
        inactiveIcon:Icon(Icons.person,size: 25,color: AppColor.blackLight,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      themeController.themeMode.value;
      return PersistentTabView(
        context,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Theme.of(context).colorScheme.surface,
        navBarStyle: NavBarStyle.style12,
      );
    });

  }
}
