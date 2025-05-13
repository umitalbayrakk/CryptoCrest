import 'dart:convert';
import 'dart:io';

import 'package:flutter_cryptocrest_app/model/btc_card_model/btc_card_model.dart';

typedef OnBtcUpdate = void Function(BtcData btcData);
class BtcWebSocketService {
  WebSocket? _socket;

  void connect({required OnBtcUpdate onUpdate}) async {
    const url = 'wss://stream.binance.com:9443/ws/btcusdt@ticker';

    try {
      _socket = await WebSocket.connect(url);
      _socket!.listen((data) {
        final jsonData = json.decode(data);
        final btcData = BtcData.fromJson(jsonData);
        onUpdate(btcData);
      });
    } catch (e) {
      print('WebSocket bağlantı hatası: $e');
    }
  }

  void disconnect() {
    _socket?.close();
  }
}
