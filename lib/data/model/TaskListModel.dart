import 'package:besttodotask/data/model/taskModel.dart';

class TaskListModel{
  final String status;
  final List<TaskModel> taskList;

  TaskListModel({required this.status, required this.taskList});

  factory TaskListModel.fromJson(Map<String, dynamic> jsonData){
    List<TaskModel> list = [];
    if(jsonData["data"] != null){
      for(Map<String, dynamic> data in jsonData["data"]){
        list.add(TaskModel.fromJson(data));
      }
    }
    return TaskListModel(
        status: jsonData["status"],
        taskList: list
    );

  }
}