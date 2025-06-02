import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/coin/coin_view.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/home/home_view.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/settings/setting_view.dart';
import 'package:get/get.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ModernGoogleNavBar extends StatelessWidget {
  const ModernGoogleNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navController = Get.put(NavController());
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: Obx(() => navController.pages[navController.selectedIndex.value]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardColor1.withOpacity(0.05) : AppColors.cardColor1.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
            ),
            child: GNav(
              gap: 6,
              backgroundColor: isDark ? const Color(0xff30444E) : AppColors.cardColor1,
              tabBackgroundColor: AppColors.greenColor,
              activeColor: isDark ? AppColors.whiteColor : AppColors.whiteColor,
              color: isDark ? AppColors.cardColor2 : AppColors.textColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: const Duration(milliseconds: 400),
              selectedIndex: navController.selectedIndex.value,
              onTabChange: (index) {
                try {
                  HapticFeedback.selectionClick();
                } catch (e) {
                  debugPrint('HapticFeedback hatası: $e');
                }
                navController.changeIndex(index);
              },
              tabs: const [
                GButton(icon: Icons.home_rounded, text: 'Ana Sayfa'),
                GButton(icon: Icons.currency_bitcoin, text: 'Coin Fiyatları'),
                GButton(icon: Icons.settings, text: 'Ayarlar'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  final List<Widget> pages = [HomeView(), CoinPricePage(), SettingsPage()];
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
