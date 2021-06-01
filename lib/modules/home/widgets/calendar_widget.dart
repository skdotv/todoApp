import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/modules/add_task/model/add_task_model.dart';
import 'package:todoapp/modules/add_task/screens/add_task_screen.dart';
import 'package:todoapp/modules/calendar/calendar_strip.dart';
import 'package:todoapp/modules/home/widgets/day_tile_widget.dart';
import 'package:todoapp/modules/home/widgets/month_name_widget.dart';
import 'package:todoapp/theme/test_style.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime endDate = DateTime.now().add(Duration(days: 30));
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              CalendarStrip(
                startDate: startDate,
                endDate: endDate,
                selectedDate: selectedDate,
                onDateSelected: onSelect,
                onWeekSelected: onWeekSelect,
                dateTileBuilder: _dateTileBuilder,
                iconColor: Colors.black87,
                monthNameWidget: _monthNameWidget,
                markedDates: markedDates,
                containerDecoration: BoxDecoration(color: Colors.black12),
                addSwipeGesture: true,
              ),
              Positioned(
                left: 10,
                top: 0,
                child: Text(
                  "To Do",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  "Create New Task",
                  style: CommonTextStyle.subTitleStyle(),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    // displayBottomSheet(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTaskScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.85),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          WatchBoxBuilder(
            box: Hive.box('task_tbl'),
            builder: (context, addTaskBox) {
              return Expanded(
                child: ListView(
                  children: List.generate(
                    addTaskBox.length,
                    (index) {
                      int i = addTaskBox.length - 1 - index;
                      final model = addTaskBox.getAt(i) as AddTaskModel;
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        color: Colors.blueAccent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            model?.title ?? "NA",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    if (date.compareTo(selectedDate) == 0) {
      print(isDateMarked.toString());
    }

    return DayTileWidget(
      date: date,
      selectedDate: selectedDate,
      rowIndex: rowIndex,
      dayName: dayName,
      isDateMarked: isDateMarked,
      isDateOutOfRange: isDateOutOfRange,
    );
  }

  _monthNameWidget(monthName) {
    return MonthNameWidget(
      monthName: monthName,
    );
  }

  onSelect(DateTime data) {
    print("Selected Date -> $data");
  }

  onWeekSelect(DateTime data) {
    setState(() {
      endDate = data.add(Duration(days: 30));
      startDate = data.subtract(Duration(days: 30));
    });
    print(endDate.toString());
  }

  List<DateTime> markedDates = [
    DateTime.now().subtract(Duration(days: 1)),
    DateTime.now().subtract(Duration(days: 2)),
    DateTime.now().add(Duration(days: 3))
  ];

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: AddTaskScreen());
        });
  }
}
