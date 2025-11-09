import 'package:flutter/material.dart';
import 'package:crypto_currency_app/models/coin_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({required this.coin, required this.index, super.key});

  final CoinModel coin;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Hero(
                  tag: coin.symbol,
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(coin.image),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(coin.symbol.toUpperCase()),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedMoney(value: coin.currentPrice),
                    Text(
                      '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: coin.priceChangePercentage24h > 0
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate(delay: (index * 100 + 1000).ms)
        .fadeIn(duration: 400.ms, curve: Curves.easeInOut)
        .slideX(begin: 0.5, duration: 400.ms, curve: Curves.easeInOut)
        .slideY(duration: 300.ms, begin: 0.5, curve: Curves.easeInOut);
  }
}

class AnimatedMoney extends StatelessWidget {
  final double value;
  final Duration duration;
  final TextStyle? style;
  final String? currencySymbol;

  const AnimatedMoney({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 1200),
    this.style,
    this.currencySymbol = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      symbol: currencySymbol,
      decimalDigits: 2,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: value),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return Text(
          formatter.format(animatedValue),
          style: style ?? Theme.of(context).textTheme.headlineSmall,
        );
      },
    );
  }
}
