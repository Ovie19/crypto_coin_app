import 'dart:convert';

import 'package:crypto_currency_app/models/coin_model.dart';
import 'package:http/http.dart' as http;

class CoinGeckoApi {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CoinModel>> fetchMarketCoins({
    int perPage = 10,
    int page = 1,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$perPage&page=$page',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result.map((e) => CoinModel.fromMap(e)).toList();
    } else {
      throw Exception('Failed to load coins: ${response.statusCode}');
    }
  }

  // Future<List<PricePoint>> fetch({required String id, int days = 7}) async {
  //   final uri = Uri.parse(
  //     '$_baseUrl/coins/$id/ohlc?vs_currency=usd&days=$days',
  //   );
  //
  //   final response = await http.get(uri);
  //
  //   if (response.statusCode == 200) {
  //     final result = jsonDecode(response.body);
  //     debugPrint(response.body);
  //     // debugPrint(result);
  //   } else {
  //     throw Exception('Failed to get coin data: ${response.statusCode}');
  //   }
  //
  //   return const [];
  // }
}
