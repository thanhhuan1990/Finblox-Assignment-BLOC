import 'dart:async';
import 'dart:convert';

import 'package:finblox_assignment_bloc/model/bitcoin_prices.dart';
import 'package:finblox_assignment_bloc/model/periods.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class BitcoinPriceRepo {
  Future<BitcoinPricesDto?> getData(Periods period) async {
    try {

      var interval = period == Periods.week ? "1h" : "1d";

      var dateFormat = DateFormat('yyyy-MM-dd');
      var start = period == Periods.week
          ? dateFormat.format(DateTime.now().subtract(const Duration(days: 6)))
          : period == Periods.month
          ? dateFormat.format(DateTime(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))
          : dateFormat.format(DateTime(DateTime.now().year, DateTime.now().month - 6, DateTime.now().day));
      // Get end date
      var tomorrow = DateTime.now().add(const Duration(days: 1));
      var end = dateFormat.format(DateTime(tomorrow.year, tomorrow.month, tomorrow.day));

      var url = Uri.parse(
          'https://data.messari.io/api/v1/markets/binance-btc-usdt/metrics/price/time-series?start=$start&end=$end&interval=$interval');
      var response = await http.get(url)
          .timeout(const Duration(seconds: 60));
      if (response.statusCode == 200) {
        return BitcoinPricesDto.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load Bitcoin prices!');
      }
    } on TimeoutException catch (_) {
      throw Exception('Time out!');
    }
  }
}
