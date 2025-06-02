import 'package:flutter/material.dart';
import 'package:flutter_cryptocrest_app/core/utils/color.dart';
import 'package:flutter_cryptocrest_app/model/web_socket_model/web_socket_model.dart';
import 'package:flutter_cryptocrest_app/service/coin_web_socket_service/crypto_web_socket_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class CoinPriceController extends GetxController {
  final WebSocketService _webSocketService = WebSocketService();
  final RxMap<String, Coin> coinMap = <String, Coin>{}.obs;
  final formatter = NumberFormat('#,##0.00');

  @override
  void onInit() {
    super.onInit();
    _webSocketService.connect(
      onUpdate: (newCoin) {
        final existing = coinMap[newCoin.symbol];
        if (existing != null) {
          coinMap[newCoin.symbol] = existing.copyWithNewPrice(newCoin.price);
        } else {
          coinMap[newCoin.symbol] = newCoin;
        }
      },
    );
  }

  @override
  void onClose() {
    _webSocketService.disconnect();
    super.onClose();
  }

  Color getPriceColor(Coin coin) {
    if (coin.previousPrice == null) return AppColors.textColor;
    if (coin.price > coin.previousPrice!) return AppColors.greenColor;
    if (coin.price < coin.previousPrice!) return AppColors.redColor;
    return Colors.black;
  }

  Icon getTrendIcon(Coin coin) {
    if (coin.previousPrice == null) return const Icon(Icons.remove, color: Colors.grey);
    if (coin.price > coin.previousPrice!) {
      return const Icon(Icons.arrow_upward, color: AppColors.greenColor);
    } else if (coin.price < coin.previousPrice!) {
      return const Icon(Icons.arrow_downward, color: AppColors.redColor);
    } else {
      return const Icon(Icons.remove, color: Colors.grey);
    }
  }
}