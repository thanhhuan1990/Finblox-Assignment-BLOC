import 'package:finblox_assignment_bloc/model/periods.dart';
import 'package:finblox_assignment_bloc/model/price_dto.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class HomeState {
  final interval = 5000.0;
  final Periods period;
  final List<PriceDto> prices;
  final List<String> titles;
  final Exception? exception;

  HomeState({
    this.period = Periods.week,
    List<PriceDto>? prices,
    List<String>? titles,
    this.exception,
  }) : prices = prices ?? [],
      titles = titles ?? [];

  HomeState clone({
    period,
    prices,
    titles,
    exception
  }) =>
      HomeState(
        period: period ?? this.period,
        prices: prices ?? this.prices,
        titles: titles ?? this.titles,
        exception: exception
      );

  int getBottomInterval() {
    switch (period) {
      case Periods.week:
        return 24;
      case Periods.month:
        return 7;
      case Periods.sixMonth:
        return 30;
    }
  }

  double getMaxPrices() {
    if (prices.isEmpty) {
      return 0;
    }
    var sorted = prices.reduce((a, b) => a.open! >= b.open! ? a : b);
    return sorted.open! + interval;
  }

  double getMinPrices() {
    if (prices.isEmpty) {
      return 0;
    }
    var sorted = prices.reduce((a, b) => a.open! <= b.open! ? a : b);
    return sorted.open! - interval;
  }
}