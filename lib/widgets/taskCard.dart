import 'package:besttodotask/data/model/taskModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

enum TaskStatus { sNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
    required this.refreshTaskList,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;
  final VoidCallback refreshTaskList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      shape: RoundedRectangleBorder(),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(widget.taskModel.description),
            Text(widget.taskModel.createDate),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  backgroundColor: _getStatusChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  shadowColor: Colors.transparent,
                  side: BorderSide.none,
                ),
                Spacer(),
                Visibility(
                  visible: _isLoading == false,
                  replacement: Center(child: SquareProgressIndicator(),),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _showUpdateStatusDialog,
                        icon: Icon(Icons.edit_note_sharp, color: Colors.green),
                      ),
                      IconButton(
                        onPressed: _deleteTask,
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: (){
                  _popDialog();
                  if(_isSelected("New")) return;
                  _updateTaskStatus("New");
                },
                title: Text("New"),
                textColor: _isSelected("New") ? Colors.green : Colors.black,
                trailing:
                    _isSelected("New")
                        ? Icon(Icons.circle, color: Colors.green,size: 14,)
                        : null,
              ),
              ListTile(
                onTap: (){
                  _popDialog();
                  if(_isSelected("Progress")) return;
                  _updateTaskStatus("Progress");
                },
                title: Text("Progress"),
                textColor:
                    _isSelected("Progress") ? Colors.green : Colors.black,
                trailing:
                    _isSelected("Progress")
                        ? Icon(Icons.circle, color: Colors.green,size: 14)
                        : null,
              ),
              ListTile(
                onTap: (){
                  _popDialog();
                  if(_isSelected("Completed")) return;
                  _updateTaskStatus("Completed");
                },
                title: Text("Complete"),
                textColor:
                    _isSelected("Completed") ? Colors.green : Colors.black,
                trailing:
                    _isSelected("Completed")
                        ? Icon(Icons.circle, color: Colors.green,size: 14)
                        : null,
              ),
              ListTile(
                onTap: (){
                  _popDialog();
                  if(_isSelected("Cancelled")) return;
                  _updateTaskStatus("Cancelled");
                },
                title: Text("Cancel"),
                textColor:
                    _isSelected("Cancelled") ? Colors.green : Colors.black,
                trailing:
                    _isSelected("Cancelled")
                        ? Icon(Icons.circle, color: Colors.green,size: 14)
                        : null,
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isSelected(status) => widget.taskModel.status == status;

  void _popDialog() {
    Navigator.pop(context);
  }

  Future<void> _updateTaskStatus(String status) async {
    _isLoading = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.updateTask(widget.taskModel.id, status),
    );
      _isLoading = false;
      setState(() {});
    if(response.isSuccess){
      widget.refreshTaskList();
    }else{
      showSnakeBarMessage(context: context, message: response.errorMessage,isError: true);
    }
  }

  Future<void> _deleteTask() async {
    _isLoading = true;
    setState(() {});
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.deleteTask(widget.taskModel.id),
    );
    _isLoading = false;
    setState(() {});
    if(response.isSuccess){
      widget.refreshTaskList();
    }else{
      showSnakeBarMessage(context: context, message: response.errorMessage,isError: true);
    }
  }


  Color _getStatusChipColor() {
    late Color color;
    switch (widget.taskStatus) {
      case TaskStatus.sNew:
        color = Colors.blue;
      case TaskStatus.progress:
        color = Colors.purple;
      case TaskStatus.cancelled:
        color = Colors.red;
      case TaskStatus.completed:
        color = Colors.green;
    }
    return color;
  }
}
