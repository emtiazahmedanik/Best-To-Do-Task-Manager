
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/taskListController.dart';
import 'package:besttodotask/screen/controller/taskStatusCountController.dart';
import 'package:besttodotask/screen/task/addNewTaskScreen.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:besttodotask/widgets/taskCard.dart';
import 'package:besttodotask/widgets/taskStatusCountWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  final _taskStatusCountController = Get.find<TaskStatusCountController>();
  final _taskListController = Get.find<TaskListController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTaskStatusCount();
    _getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                buildTaskListCountView(),
                GetBuilder<TaskListController>(
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: _taskListController.getTaskList.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskStatus: TaskStatus.sNew,
                            taskModel: _taskListController.getTaskList[index],
                            refreshTaskList: _refreshScreen,
                          );
                        },
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 8),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          GetBuilder<TaskListController>(
            builder: (_) {
              return _taskListController.getIsTaskLoading
                  ? Container(
                color: Colors.black.withAlpha(50),
                child: Center(
                  child: SquareProgressIndicator(color: Colors.green),
                ),
              )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFloatingActionButton,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  void _refreshScreen() {
    _getAllTask();
    _getAllTaskStatusCount();
  }

  Future<void> _getAllTaskStatusCount() async {
    final bool isSuccess =
        await _taskStatusCountController.getAllTaskStatusCount();
    if (isSuccess) {
    } else {
      showSnakeBarMessage(
        context: context,
        message: _taskStatusCountController.getErrorMsg,
        isError: true,
      );
    }
  }

  Future<void> _getAllTask() async {
    final bool isSuccess = await _taskListController.getAllTask(Urls.newTask);
    if (isSuccess) {
    } else {
      showSnakeBarMessage(
        context: context,
        message: _taskListController.getErrorMsg,
        isError: true,
      );
    }
  }

  void _onTapFloatingActionButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    ).then((result) {
      if (result == "updated") {
        _refreshScreen();
      }
    });
  }
}
