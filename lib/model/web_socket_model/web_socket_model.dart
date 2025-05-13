class Coin {
  final String symbol;
  final double price;
  double? previousPrice;

  Coin({
    required this.symbol,
    required this.price,
    this.previousPrice,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      symbol: json['s'], 
      price: double.parse(json['c']),
    );
  }

  String get shortSymbol => symbol.replaceAll('USDT', '');

  Coin copyWithNewPrice(double newPrice) {
    return Coin(
      symbol: symbol,
      price: newPrice,
      previousPrice: price,
    );
  }
}
