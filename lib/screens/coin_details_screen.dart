import 'package:crypto_currency_app/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinDetailsScreen extends StatelessWidget {
  const CoinDetailsScreen({required this.coin, super.key});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(tag: coin.symbol, child: Image.network(coin.image)),
      ),
    );
  }
}
