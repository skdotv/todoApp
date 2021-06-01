import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/modules/add_task/bloc/add_task_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/widgets/common_button.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _addTaskFormKey = GlobalKey<FormState>();
  AddTaskBloc _addTaskBloc = AddTaskBloc();

  @override
  void initState() {
    super.initState();
    Hive.openBox('task_tbl');
  }

  @override
  void dispose() {
    super.dispose();
    // Hive.box('task_tbl').close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        key: _scaffoldState,
        body: _addTaskForm(),
      ),
    ));
  }

  Widget _addTaskForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(30.0),
            topRight: const Radius.circular(30.0)),
      ),
      child: Form(
        key: _addTaskFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              _titleFormField(),
              _startTimeField(),
              _reminderField(),
              _descriptionFormField(),
              SizedBox(
                height: 10,
              ),
              Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: _bottomButtonField()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(30.0),
                topRight: const Radius.circular(30.0)),
          ),
          margin: EdgeInsets.only(left: 25, top: 20, bottom: 5),
          width: MediaQuery.of(context).size.width * 0.7,
          child: StreamBuilder<String>(
              stream: _addTaskBloc.titleController,
              builder: (context, snapshot) {
                return TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  maxLines: 5,
                  autofocus: false,
                  onChanged: (value) {
                    _addTaskBloc.titleController.sink.add(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Field is required";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    isDense: true,
                    hintText: "Write task here",
                    hintStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    focusColor: Colors.transparent,
                    fillColor: Colors.white,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                );
              }),
        ),
      ],
    );
  }

  bool _isAlarm = false;

  Widget _startTimeField() {
    return StreamBuilder<DateTime>(
        stream: _addTaskBloc.startTimeController,
        initialData: _addTaskBloc.startTimeController.value,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                maintainState: true,
                title: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.alarm,
                        color: Theme.of(context).primaryColor,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      // "E, d MMM hh:mm a"
                      DateFormat("hh:mm a").format(snapshot.data),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                children: [
                  startTimeSpinner(_addTaskBloc),
                ],
              ),
            ),
          );
        });
  }

  Widget _reminderField() {
    return StreamBuilder<DateTime>(
        stream: _addTaskBloc.startTimeController,
        initialData: _addTaskBloc.startTimeController.value,
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.notifications_active_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 25,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "15 min before",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Switch(
                    activeColor: Colors.greenAccent.shade700,
                    value: _isAlarm,
                    onChanged: (bool value) {
                      setState(() {
                        _isAlarm = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _descriptionFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, top: 10, right: 10),
          child: Icon(
            Icons.note_add_outlined,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 25, top: 10, bottom: 5),
          width: MediaQuery.of(context).size.width * 0.7,
          child: StreamBuilder<String>(
              stream: _addTaskBloc.descriptionController,
              builder: (context, snapshot) {
                return TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: false,
                  keyboardType: TextInputType.name,
                  maxLines: 5,
                  autofocus: false,
                  onChanged: (value) {
                    _addTaskBloc.descriptionController.sink.add(value);
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Description is Required";
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 5),
                    isDense: true,
                    hintText: "Notes",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    focusColor: Colors.transparent,
                    fillColor: Colors.white,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _bottomButtonField() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          CommonButton(
            buttonColor: Theme.of(context).primaryColor,
            isLabelBold: true,
            label: "Save",
            onTap: () {
              _addTaskBloc.saveTask();
              Navigator.pop(context);
            },
            width: 0.8,
            height: 30,
          )
          // RaisedButton(
          //   elevation: 5,
          //   padding: EdgeInsets.symmetric(horizontal: 40),

          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //   color: Colors.black,
          //   // Colors.grey[600],
          //   onPressed: () {
          //     print("cancel");
          //     Navigator.pop(context);
          //   },
          //   child: Text(
          //     "Cancel",
          //     style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.white),
          //   ),
          // ),
          // RaisedButton(
          //   elevation: 5,

          //   padding: EdgeInsets.symmetric(horizontal: 40),
          //   shape:
          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //   color: Colors.black,
          //   //  Colors.green[500],
          //   onPressed: () {
          //     _addTaskBloc.saveTask();
          //     Navigator.pop(context);
          //   },
          //   child: Text(
          //     "Save",
          //     style: TextStyle(
          //         fontSize: 20,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.white),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget startTimeSpinner(AddTaskBloc addTaskBloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.w300),
        highlightedTextStyle: TextStyle(fontSize: 24, color: Colors.black),
        spacing: 40,
        itemHeight: 40,
        isForce2Digits: true,
        minutesInterval: 1,
        onTimeChange: (DateTime time) {
          addTaskBloc.startTimeController.sink.add(time);
        },
      ),
    );
  }
}
