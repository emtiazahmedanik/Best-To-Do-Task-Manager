class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createDate;

  TaskModel(
      {required this.id, required this.title, required this.description, required this.status,
        required this.createDate});

  factory TaskModel.fromJson(Map<String, dynamic> jsonData){
    return TaskModel(
        id: jsonData["_id"],
        title: jsonData["title"] ?? "",
        description: jsonData["description"] ?? "",
        status: jsonData["status"] ?? "",
        createDate: jsonData["createdDate"] ?? "");
  }

}