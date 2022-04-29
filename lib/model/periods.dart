/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.

enum Periods {
  week,
  month,
  sixMonth
}

extension ParseToString on Periods {
  String toDisplayString() {
    switch (this) {
      case Periods.week:
        return 'Week';
      case Periods.month:
        return 'Month';
      case Periods.sixMonth:
        return '6 Months';
    }
  }
}
