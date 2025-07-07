import 'package:besttodotask/data/model/taskStatusCountListModel.dart';
import 'package:besttodotask/data/model/taskStatusCountModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:get/get.dart';

class TaskStatusCountController extends GetxController {
  bool _isStatusCountLoading = false;
  get  getIsStatusCountLoading => _isStatusCountLoading;
  set setIsStatusCountLoading(value){
    _isStatusCountLoading = value;
    update();
  }
  List<TaskStatusCountModel> _taskCountList = [];
  get getTaskCountList => _taskCountList;

  bool isSuccess = false;
  String? _errorMsg;
  get getErrorMsg => _errorMsg;

  Future<bool> getAllTaskStatusCount() async {
    _isStatusCountLoading = true;
    update();
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCount,
    );

    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskCountList = taskStatusCountListModel.statusCountList;
      isSuccess = true;
      _errorMsg = null;
    } else {
      _errorMsg = response.errorMessage;
    }
    _isStatusCountLoading = false;
    update();

    return isSuccess;
  }
}
