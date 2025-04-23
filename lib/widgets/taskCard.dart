import 'package:besttodotask/data/model/taskModel.dart';
import 'package:flutter/material.dart';

enum TaskStatus { sNew, progress, completed, cancelled }

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskStatus,
    required this.taskModel,
  });

  final TaskStatus taskStatus;
  final TaskModel taskModel;

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
              taskModel.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(taskModel.description),
            Text(taskModel.createDate),
            Row(
              children: [
                Chip(
                  label: Text(
                    taskModel.status,
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_note_sharp, color: Colors.green),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusChipColor() {
    late Color color;
    switch (taskStatus) {
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
