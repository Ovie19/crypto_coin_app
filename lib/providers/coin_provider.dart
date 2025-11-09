import 'package:crypto_currency_app/models/coin_model.dart';
import 'package:crypto_currency_app/services/coingecko_api.dart';
import 'package:flutter_riverpod/legacy.dart';

class CoinState {
  final List<CoinModel> coins;
  final bool isLoading;
  final String? error;

  CoinState({this.coins = const [], this.isLoading = true, this.error});

  CoinState copyWith({List<CoinModel>? coins, bool? isLoading, String? error}) {
    return CoinState(
      coins: coins ?? this.coins,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CoinNotifier extends StateNotifier<CoinState> {
  final CoinGeckoApi api;

  CoinNotifier(this.api) : super(CoinState());

  Future<void> loadMarket() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final coinList = await api.fetchMarketCoins();
      state = state.copyWith(coins: coinList, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final coinProvider = StateNotifierProvider<CoinNotifier, CoinState>((ref) {
  return CoinNotifier(CoinGeckoApi());
});
