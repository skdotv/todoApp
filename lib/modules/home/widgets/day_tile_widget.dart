import 'package:flutter/material.dart';
import 'package:todoapp/modules/home/widgets/get_marker_widget.dart';

class DayTileWidget extends StatelessWidget {
  final dynamic selectedDate;
  final dynamic isDateOutOfRange;
  final dynamic date;
  final dynamic rowIndex;
  final dynamic isDateMarked;
  final dynamic dayName;

  const DayTileWidget({
    Key key,
    this.selectedDate,
    this.isDateOutOfRange,
    this.date,
    this.rowIndex,
    this.isDateMarked,
    this.dayName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor =
        isDateOutOfRange ? Colors.black26 : Theme.of(context).primaryColor;
    TextStyle normalStyle = TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);
    TextStyle selectedStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
    );
    TextStyle dayNameStyle = TextStyle(
        fontWeight: isSelectedDate ? FontWeight.bold : FontWeight.normal,
        fontSize: isSelectedDate ? 14.5 : 14,
        color: isSelectedDate ? fontColor : Colors.grey[600]);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];
    if (isDateMarked == true) {
      _children.add(GetMarkerWidget());
    }

    return AnimatedContainer(
      height: 70,
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 5, right: 5),
      padding: EdgeInsets.only(top: 8, left: 0, right: 0, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate
            ? Colors.transparent
            : Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }
}
