class BtcData {
  final String symbol;
  final double lastPrice;
  final double priceChangePercent;

  BtcData({
    required this.symbol,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  factory BtcData.fromJson(Map<String, dynamic> json) {
    return BtcData(
      symbol: json['s'],
      lastPrice: double.parse(json['c']),
      priceChangePercent: double.parse(json['P']),
    );
  }
}
