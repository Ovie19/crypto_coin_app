class PricePoint {
  PricePoint({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  factory PricePoint.fromMap(List<dynamic> priceList) {
    return PricePoint(
      time: DateTime.fromMillisecondsSinceEpoch(priceList[0]),
      open: (priceList[1] as num).toDouble(),
      high: (priceList[2] as num).toDouble(),
      low: (priceList[3] as num).toDouble(),
      close: (priceList[4] as num).toDouble(),
    );
  }
}
