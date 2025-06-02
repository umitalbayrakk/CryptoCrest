import 'package:flutter_cryptocrest_app/model/btc_card_model/btc_card_model.dart';
import 'package:flutter_cryptocrest_app/service/btc_web_socked_card_service/btc_web_socket_service.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BtcPriceCardController extends GetxController {
  final BtcWebSocketService _btcService = BtcWebSocketService();
  final Rx<BtcData?> btcData = Rx<BtcData?>(null);
  final RxBool isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _connectToWebSocket();
  }

  @override
  void onClose() {
    _btcService.disconnect();
    super.onClose();
  }

  void _connectToWebSocket() {
    _btcService.connect(
      onUpdate: (data) {
        btcData.value = data;
        isConnected.value = true;
      },
    );
  }
}
