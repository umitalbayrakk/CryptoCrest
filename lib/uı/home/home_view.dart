import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/widgets/appbar/abbar_widgets.dart';
import 'package:flutter_cryptocrest_app/widgets/btc_price_card/btc_price_card_widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(),
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(children: [SizedBox(height: 20), BtcPriceCard(), SizedBox(height: 20),]),
    );
  }
}
