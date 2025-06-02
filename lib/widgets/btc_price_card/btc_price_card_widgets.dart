import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/controller/btc_price_card_controller.dart';
import 'package:flutter_cryptocrest_app/u%C4%B1/coin/coin_view.dart';
import 'package:get/get.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';

class BtcPriceCard extends StatelessWidget {
  const BtcPriceCard({super.key});

  @override
  Widget build(BuildContext context) {
    
    Get.put(BtcPriceCardController());
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CoinPricePage()));
        },
        child: Container(
          decoration: BoxDecoration(color: AppColors.cardColor2, borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BTC/USDT',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
                    ),
                    _buildConnectionStatus(),
                  ],
                ),
                const SizedBox(height: 10),
                _buildPriceInfo(),
                const SizedBox(height: 8),
                _buildChangePercentage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Obx(() {
      final controller = Get.find<BtcPriceCardController>();
      return Row(
        children: [
          Icon(
            controller.isConnected.value ? Icons.circle : Icons.circle_outlined,
            color: controller.isConnected.value ? AppColors.greenColor : Colors.grey,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            controller.isConnected.value ? 'Canlı' : 'Yükleniyor...',
            style: TextStyle(color: controller.isConnected.value ? AppColors.greenColor : Colors.grey, fontSize: 12),
          ),
        ],
      );
    });
  }

  Widget _buildPriceInfo() {
    return Obx(() {
      final controller = Get.find<BtcPriceCardController>();
      return Row(
        children: [
          Text(
            controller.btcData.value != null ? '\$${controller.btcData.value!.lastPrice.toStringAsFixed(2)}' : '--',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
          ),
        ],
      );
    });
  }

  Widget _buildChangePercentage() {
    return Obx(() {
      final controller = Get.find<BtcPriceCardController>();
      final changePercent = controller.btcData.value?.priceChangePercent ?? 0;
      final isPositive = changePercent >= 0;

      return Row(
        children: [
          Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: isPositive ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            controller.btcData.value != null ? '${changePercent.toStringAsFixed(2)}%' : '--',
            style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
            controller.btcData.value != null ? '24 Saatlik' : '',
            style: const TextStyle(color: AppColors.textColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }
}
