import 'package:finblox_assignment_bloc/view/home/home_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Finblox Demo by BLOC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeWidget(),
    );
  }
}