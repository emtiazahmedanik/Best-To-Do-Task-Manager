import 'package:besttodotask/data/model/TaskListModel.dart';
import 'package:besttodotask/data/model/taskModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:get/get.dart';

class TaskListController extends GetxController {
  bool _isTaskLoading = false;
  get getIsTaskLoading => _isTaskLoading;
  List<TaskModel> _taskList = [];
  get getTaskList => _taskList;
  bool isSuccess = false;
  String? _errorMsg;
  get getErrorMsg => _errorMsg;

  Future<bool> getAllTask(String url) async {
    _isTaskLoading = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(url: url);
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
      _taskList = taskListModel.taskList;
      isSuccess = true;
      _errorMsg = null;
    } else {
      _errorMsg = response.errorMessage;
    }

    _isTaskLoading = false;
    update();
    return isSuccess;
  }
}
