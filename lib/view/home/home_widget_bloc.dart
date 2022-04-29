import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finblox_assignment_bloc/model/periods.dart';
import 'package:finblox_assignment_bloc/model/price_dto.dart';
import 'package:finblox_assignment_bloc/repository/price_repository.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_event.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_state.dart';
import 'package:intl/intl.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class HomeWidgetBloc extends Bloc<BaseEvent, HomeState> {
  HomeWidgetBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(BaseEvent event,) async* {
    if (event is GetPriceData) {
      yield* getPrices(event);
    }
  }

  int getBottomInterval() {
    switch (state.period) {
      case Periods.week:
        return 24;
      case Periods.month:
        return 7;
      case Periods.sixMonth:
        return 30;
    }
  }

  Stream<HomeState> getPrices(GetPriceData event) async* {
    yield state.clone(period: event.periods, prices: <PriceDto>[], titles: <String>[]);

    try {
      final data = await BitcoinPriceRepo().getData(event.periods);

      final values = data?.data?.values;
      List<String> titles = [];
      if (values != null) {
        for (var element in values) {
          if (element.timeStamp != null) {
            titles.add(DateFormat(event.periods == Periods.sixMonth ? "MMM" : "dd MMM")
                .format(DateTime.fromMillisecondsSinceEpoch(element.timeStamp!)));
          }
        }
      }
      yield state.clone(
          prices: values,
          titles: titles,
          exception: null
      );
    } catch (e) {
      yield state.clone(exception: e);
    }
  }
}