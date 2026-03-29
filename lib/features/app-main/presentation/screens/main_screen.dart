import 'package:career/core/constant/class/app_asset.dart';
import 'package:career/core/constant/class/app_color.dart';
import 'package:career/features/find_job/presentation/screen/find_job_screen.dart';
import 'package:career/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../book-mark/presentation/screen/advertisement_screen.dart';
import '../../../home/presentation/screen/home_screen.dart';


class MainScreen extends StatelessWidget {

  final PersistentTabController persistentController =
  PersistentTabController(initialIndex: 0);

  MainScreen({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      AdvertisementScreen(),
      FindJobScreen(),
      ProfileScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAsset.homeBold,height: 20,),
        inactiveIcon: SvgPicture.asset(AppAsset.home,height: 20,),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAsset.advBold,height: 20,),
        inactiveIcon: SvgPicture.asset(AppAsset.adv,height: 20,),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAsset.searchWorkBold,height: 20,),
        inactiveIcon: SvgPicture.asset(AppAsset.searchWork,height: 20,),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(AppAsset.profileBold,height: 20,),
        inactiveIcon: SvgPicture.asset(AppAsset.profile,height: 20,),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor:AppColor.secondryColor,
      navBarStyle: NavBarStyle.style12,
    );

  }
}
