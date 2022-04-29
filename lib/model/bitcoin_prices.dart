import 'bitcoin_data_dto.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class BitcoinPricesDto {
  late BitcoinDataDto? data;

  BitcoinPricesDto({
    required this.data
  });

  factory BitcoinPricesDto.fromJson(Map<String, dynamic> json) {
    return BitcoinPricesDto(
      data: json['data'] != null ? BitcoinDataDto.fromJson(json['data']) : null,
    );
  }
}