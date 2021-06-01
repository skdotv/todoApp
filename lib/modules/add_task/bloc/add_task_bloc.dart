import 'package:rxdart/rxdart.dart';
import 'package:todoapp/modules/add_task/model/add_task_model.dart';

class AddTaskBloc {
  AddTaskBloc() {
    this.getData();
    this.titleController.listen(_titleListener);

    this.startTimeController.listen(_startTimeListener);
    this.descriptionController.listen(_descriptionListener);
    this.savebuttonController.listen(_saveButtonListener);
  }

  // variable declaration - start

  AddTaskModel _addTaskModel = AddTaskModel.zero();

  // variable declaration - end

  // controllers - start
  final titleController = BehaviorSubject<String>();
  final startTimeController = BehaviorSubject<DateTime>.seeded(DateTime.now());
  final descriptionController = BehaviorSubject<String>();
  final savebuttonController = BehaviorSubject<String>();
  final colorController = BehaviorSubject<String>();
  // controllers - end

  // listener - start
  void _titleListener(String value) {
    _addTaskModel.title = value;
  }

  void _startTimeListener(DateTime value) {
    _addTaskModel.startTime = value;
  }

  void _descriptionListener(String value) {
    _addTaskModel.notes = value;
  }

  void _saveButtonListener(String value) {}

  // listener - end
  saveTask() {
    Map<String, dynamic> todos = {
      "title": _addTaskModel?.title ?? "",
      "start_time": _addTaskModel?.startTime?.millisecondsSinceEpoch ?? "",
      // "end_time": _addTaskModel?.endTime?.millisecondsSinceEpoch ?? "",
      "description": _addTaskModel?.notes ?? "",
      "color": colorController?.value ?? ""
    };
    AddTaskModel _model = AddTaskModel(
        _addTaskModel?.title, _addTaskModel.startTime, _addTaskModel?.notes);
    AddTaskModel.addTask(_model);
    getData();
  }

  getData() {
    var _data = AddTaskModel.getData();
    print(_data);
  }

  void dispose() {
    titleController.close();
    startTimeController.close();
    descriptionController.close();
    savebuttonController.close();
    colorController.close();
  }
}
