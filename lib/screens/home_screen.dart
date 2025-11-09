import 'package:crypto_currency_app/providers/coin_provider.dart';
import 'package:crypto_currency_app/screens/coin_details_screen.dart';
import 'package:crypto_currency_app/services/coingecko_api.dart';
import 'package:crypto_currency_app/widgets/coin_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => ref.read(coinProvider.notifier).loadMarket());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(coinProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cryptocurrency',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(color: Colors.white),
        ),
      ),
      body: state.isLoading
          ? Center(
              child: LottieBuilder.asset(
                'assets/lottie/loading.json',
                height: 150,
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CoinDetailsScreen(coin: state.coins[index]),
                        ),
                      ),
                      child: CoinCard(coin: state.coins[index], index: index),
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: state.coins.length,
                ),
              ),
            ),
    );
  }
}
