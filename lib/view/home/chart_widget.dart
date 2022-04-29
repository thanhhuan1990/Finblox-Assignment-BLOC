import 'package:finblox_assignment_bloc/view/home/home_widget_bloc.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<HomeWidgetBloc>(context);
    List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: Color(0xff232d37)),
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
        child: BlocConsumer(
          bloc: bloc,
          listener: (BuildContext context, HomeState state) {
            if (state.exception != null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Something when wrong!\nPlease change the period to retry."),
              ));
            }
          },
          builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.center,
              children: [
                LineChart(LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: const Color(0xff37434d),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: bloc.getBottomInterval().toDouble(),
                      getTextStyles: (context, value) =>
                      const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 11),
                      getTitles: (value) => bloc.state.titles.isEmpty || value.toInt() > bloc.state.titles.length
                          ? ''
                          : bloc.state.titles[value.toInt()],
                      margin: 8,
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      interval: bloc.state.interval,
                      getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff67727d),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      getTitles: (value) => "${(value ~/ 1000)}k",
                      reservedSize: 32,
                      margin: 12,
                    ),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
                  minX: 0,
                  maxX: bloc.state.prices.length.toDouble(),
                  minY: bloc.state.getMinPrices(),
                  maxY: bloc.state.getMaxPrices(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: bloc.state.prices
                          .map((e) => FlSpot(bloc.state.prices.indexOf(e).toDouble(), e.open != null ? e.open! : 0))
                          .toList(),
                      isCurved: true,
                      colors: gradientColors,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                      ),
                    ),
                  ],
                )),
                (bloc.state.prices.isEmpty && bloc.state.exception == null)
                    ? const SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: CircularProgressIndicator(
                    value: null,
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
                    : const SizedBox()
              ],
            );
          }
        ),
      ),
    );
  }
}
