import 'dart:convert';
import 'dart:io';

import 'package:flutter_cryptocrest_app/model/web_socket_model/web_socket_model.dart';

typedef OnCoinUpdate = void Function(Coin coin);

class WebSocketService {
  WebSocket? _socket;

  void connect({required OnCoinUpdate onUpdate}) async {
    const url =
        'wss://stream.binance.com:9443/stream?streams=btcusdt@ticker/ethusdt@ticker/bnbusdt@ticker/xrpusdt@ticker/solusdt@ticker/adausdt@ticker/dogeusdt@ticker/maticusdt@ticker/ltcusdt@ticker/linkusdt@ticker/dotusdt@ticker/tronusdt@ticker/avaxusdt@ticker/xlmusdt@ticker/uniusdt@ticker';

    _socket = await WebSocket.connect(url);
    _socket!.listen((data) {
      final jsonData = json.decode(data);
      final coinData = jsonData['data'];
      final coin = Coin.fromJson(coinData);
      onUpdate(coin);
    });
  }

  void disconnect() {
    _socket?.close();
  }
}
