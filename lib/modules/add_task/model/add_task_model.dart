import 'package:hive/hive.dart';

part 'add_task_model.g.dart';

@HiveType(typeId: 0)
class AddTaskModel extends HiveObject {
  @HiveField(0)
  String _title;
  @HiveField(1)
  DateTime _startTime;
  @HiveField(2)
  String _notes;
  AddTaskModel(
    this._title,
    this._startTime,
    this._notes,
  );
  AddTaskModel.zero();

  static void addTask(AddTaskModel addTaskModel) {
    final addTaskBox = Hive.box('task_tbl');
    var d = addTaskBox.add(addTaskModel);
    print(d.toString());
  }

  static Box<dynamic> getData() {
    try {
      final data = Hive.box('task_tbl');
      print(data);
      return data;
    } catch (e) {}
  }

  set title(String title) {
    this._title = title;
  }

  set startTime(DateTime time) {
    this._startTime = time;
  }

  set notes(String notes) {
    this._notes = notes;
  }

  String get title => this._title;
  DateTime get startTime => this._startTime;
  String get notes => this._notes;
}
