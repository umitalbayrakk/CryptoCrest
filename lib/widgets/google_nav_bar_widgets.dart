import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/coin/coin_view.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/home/home_view.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/weather/weather_view.dart';
import 'package:flutter_cryptocrest_app/widgets/abbar/abbar_widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ModernGoogleNavBar extends StatefulWidget {
  const ModernGoogleNavBar({super.key});

  @override
  State<ModernGoogleNavBar> createState() => _ModernGoogleNavBarState();
}

class _ModernGoogleNavBarState extends State<ModernGoogleNavBar> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [HomeView(), WeatherView(), CoinPricePage()];
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1)),
            ),
            child: GNav(
              gap: 6,
              backgroundColor: isDark ? const Color(0xff30444E) : const Color(0xFFFFFFFF),
              tabBackgroundColor: AppColors.appBarColor,
              activeColor: isDark ? Colors.white : Colors.white,
              color: isDark ? Colors.white70 : Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: const Duration(milliseconds: 400),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                try {
                  HapticFeedback.selectionClick();
                } catch (e) {
                  debugPrint('HapticFeedback hatası: $e');
                }
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(icon: Icons.home_rounded, text: 'Ana Sayfa'),
                GButton(icon: Icons.cloud, text: 'Hava Durumu'),
                GButton(icon: Icons.currency_bitcoin, text: 'Coin Fiyatları'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
