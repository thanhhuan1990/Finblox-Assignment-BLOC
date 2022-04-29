
import 'package:finblox_assignment_bloc/model/price_dto.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class BitcoinDataDto {
  late List<PriceDto>? values;

  BitcoinDataDto({required this.values});

  factory BitcoinDataDto.fromJson(Map<String, dynamic> json) {
    return BitcoinDataDto(
        values: json['values'] != null
            ? List.from(json['values']).map((data) {
                return PriceDto(
                  timeStamp: data[0] as int,
                  open: (data[1] is int) ? (data[1] as int).toDouble() : data[1] as double,
                );
              }).toList()
            : null);
  }
}
