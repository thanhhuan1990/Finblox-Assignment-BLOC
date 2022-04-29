import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:finblox_assignment_bloc/model/periods.dart';
import 'package:finblox_assignment_bloc/view/home/chart_widget.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_bloc.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_event.dart';
import 'package:finblox_assignment_bloc/view/home/home_widget_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Created by Huan.Huynh on 09/11/2021
///
/// Copyright © 2021 by Huan.Huynh All rights reserved.
class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  final bloc = HomeWidgetBloc(HomeState());
  @override
  void initState() {
    super.initState();
    bloc.add(const GetPriceData(Periods.week));
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (_) => bloc,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text("Finblox Demo By BLOC"),
            backgroundColor: Colors.teal,
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: ChartWidget(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<HomeWidgetBloc, HomeState>(builder: (context, state) {
                return CustomRadioButton(
                  buttonTextStyle: const ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Color(0xff212836),
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  selectedColor: const Color(0xff212836),
                  unSelectedColor: Colors.white,
                  selectedBorderColor: const Color(0xff212836),
                  unSelectedBorderColor: Colors.white,
                  buttonLables: Periods.values.map((e) => e.toDisplayString()).toList(),
                  buttonValues: Periods.values,
                  spacing: 0,
                  defaultSelected: state.period,
                  enableButtonWrap: true,
                  absoluteZeroSpacing: false,
                  enableShape: true,
                  padding: 10,
                  radioButtonValue: (values) {
                    bloc.add(GetPriceData(values as Periods));
                  },
                  wrapAlignment: WrapAlignment.spaceEvenly,
                );
              }),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

}