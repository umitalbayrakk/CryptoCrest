import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/controller/coin_price_controller.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/widgets/appbar/abbar_widgets.dart';
import 'package:get/get.dart';

class CoinPricePage extends StatelessWidget {
  const CoinPricePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CoinPriceController controller = Get.put(CoinPriceController());
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      appBar: AppBarWidgets(),
      body: Obx(() {
        final coins = controller.coinMap.values.toList()..sort((a, b) => a.symbol.compareTo(b.symbol));
        return ListView.builder(
          itemCount: coins.length,
          itemBuilder: (context, index) {
            final coin = coins[index];
            return Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.textColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.cardColor2),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.textColor,
                      child: Text(
                        coin.shortSymbol.substring(0, 2),
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.cardColor1),
                      ),
                    ),
                    title: Text(coin.shortSymbol, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: const Text("USDT paritesi"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${controller.formatter.format(coin.price)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: controller.getPriceColor(coin),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        controller.getTrendIcon(coin),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
