import 'package:besttodotask/data/model/taskStatusCountModel.dart';

class TaskStatusCountListModel {
  final String status;
  final List<TaskStatusCountModel> statusCountList;

  TaskStatusCountListModel({
    required this.status,
    required this.statusCountList,
  });

  factory TaskStatusCountListModel.fromJson(Map<String, dynamic> jsonData) {
    List<TaskStatusCountModel> countList = [];
    if (jsonData["data"] != null) {
      for(Map<String, dynamic> data in jsonData["data"]){
        countList.add(TaskStatusCountModel.fromJson(data));
      }
    }
    return TaskStatusCountListModel(
      status: jsonData["status"],
      statusCountList: countList,
    );
  }
}
