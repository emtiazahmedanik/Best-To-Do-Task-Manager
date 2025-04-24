import 'package:besttodotask/data/model/TaskListModel.dart';
import 'package:besttodotask/data/model/taskModel.dart';
import 'package:besttodotask/data/model/taskStatusCountListModel.dart';
import 'package:besttodotask/data/model/taskStatusCountModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:besttodotask/widgets/summaryTask.dart';
import 'package:besttodotask/widgets/taskCard.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';



class CancelledTaskListScreen extends StatefulWidget {
  const CancelledTaskListScreen({super.key});

  @override
  State<CancelledTaskListScreen> createState() => _CancelledTaskListScreenState();
}

class _CancelledTaskListScreenState extends State<CancelledTaskListScreen> {
  bool _isStatusCountLoading = false;
  bool _isTaskLoading = false;

  List<TaskModel> _taskList = [];
  List<TaskStatusCountModel> _taskCountList = [];

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
      body:
      _isTaskLoading
          ? Center(child: SquareProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
        child: Column(
          children: [
            buildSingleChildScrollView(),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.cancelled,
                  taskModel: _taskList[index],
                  refreshTaskList: _refreshScreen,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ],
        ),
      ),

    );
  }

  Widget buildSingleChildScrollView() {
    return _isStatusCountLoading
        ? Center(child: SquareProgressIndicator())
        : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _taskCountList.length,
            itemBuilder: (context, index) {
              return SummaryTask(
                title: _taskCountList[index].status,
                count: _taskCountList[index].count,
              );
            },
          ),
        ),
      ),
    );
  }

  void _refreshScreen(){
    _getAllTask();
    _getAllTaskStatusCount();
  }

  Future<void> _getAllTaskStatusCount() async {
    setState(() {
      _isStatusCountLoading = true;
    });
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCount,
    );
    setState(() {
      _isStatusCountLoading = false;
    });
    if (response.isSuccess) {
      TaskStatusCountListModel taskStatusCountListModel =
      TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskCountList = taskStatusCountListModel.statusCountList;
    } else {
      showSnakeBarMessage(
        context: context,
        message: response.errorMessage,
        isError: true,
      );
    }
  }

  Future<void> _getAllTask() async {
    setState(() {
      _isTaskLoading = true;
    });
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.cancelledTask,
    );
    setState(() {
      _isTaskLoading = false;
    });
    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data!);
        _taskList = taskListModel.taskList;
    } else {
      showSnakeBarMessage(
        context: context,
        message: response.errorMessage,
        isError: true,
      );
    }
  }


}



