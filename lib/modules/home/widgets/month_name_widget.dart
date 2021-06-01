import 'package:flutter/material.dart';

class MonthNameWidget extends StatelessWidget {
  final dynamic monthName;
  const MonthNameWidget({
    Key key,
    this.monthName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Text(
        monthName,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 20),
    );
  }
}
