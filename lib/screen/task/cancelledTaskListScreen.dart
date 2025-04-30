import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/taskListController.dart';
import 'package:besttodotask/screen/controller/taskStatusCountController.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:besttodotask/widgets/taskCard.dart';
import 'package:besttodotask/widgets/taskStatusCountWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() =>
      _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
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
                    return ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: _taskListController.getTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskStatus: TaskStatus.cancelled,
                          taskModel: _taskListController.getTaskList[index],
                          refreshTaskList: _refreshScreen,
                        );
                      },
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 8),
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
    final bool isSuccess = await _taskListController.getAllTask(
      Urls.cancelledTask,
    );
    if (isSuccess) {
    } else {
      showSnakeBarMessage(
        context: context,
        message: _taskListController.getErrorMsg!,
        isError: true,
      );
    }
  }
}
