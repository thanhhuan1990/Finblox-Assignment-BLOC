import 'package:equatable/equatable.dart';
import 'package:finblox_assignment_bloc/model/periods.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
abstract class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object> get props => [];
}

class GetPriceData extends BaseEvent {
  final Periods periods;
  const GetPriceData(this.periods);

  @override
  List<Object> get props => [periods];
  @override
  String toString() => 'GetPriceData { periods: $periods }';
}