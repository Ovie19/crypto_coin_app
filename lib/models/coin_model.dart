class CoinModel {
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.priceChangePercentage24h,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double priceChangePercentage24h;

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'] as String,
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      currentPrice: (map['current_price'] as num).toDouble(),
      priceChangePercentage24h: (map['price_change_percentage_24h'] as num)
          .toDouble(),
    );
  }

  @override
  String toString() {
    return 'CoinModel{id: $id, symbol: $symbol, name: $name, currentPrice: $currentPrice, priceChangePercentage24h: $priceChangePercentage24h}';
  }
}
