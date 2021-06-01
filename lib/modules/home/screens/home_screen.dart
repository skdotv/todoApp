import 'package:flutter/material.dart';
import 'package:todoapp/modules/home/widgets/calendar_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          CalendarWidget()
        ],
      ),
    );
  }
}
