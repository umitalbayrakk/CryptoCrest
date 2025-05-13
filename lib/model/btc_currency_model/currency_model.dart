class CurrencyRate {
  final String currencyCode;
  final String currencyName;
  final double buyingRate;
  final double sellingRate;

  CurrencyRate({
    required this.currencyCode,
    required this.currencyName,
    required this.buyingRate,
    required this.sellingRate,
  });

  factory CurrencyRate.fromMap(String code, String name, double buying, double selling) {
    return CurrencyRate(
      currencyCode: code,
      currencyName: name,
      buyingRate: buying,
      sellingRate: selling,
    );
  }
}