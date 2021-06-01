import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:todoapp/modules/add_task/model/add_task_model.dart';

class InitializeData {
  static initDatabase() async {
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(AddTaskModelAdapter());
    // open box

    Hive.openBox('task_tbl');
  }
}
