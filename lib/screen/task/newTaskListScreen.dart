import 'package:besttodotask/data/model/taskStatusCountListModel.dart';
import 'package:besttodotask/data/model/taskStatusCountModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/task/addNewTaskScreen.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:besttodotask/widgets/summaryTask.dart';
import 'package:besttodotask/widgets/taskCard.dart';
import 'package:flutter/material.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  bool _isLoading = false;
  List<TaskStatusCountModel> _taskCountList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSingleChildScrollView(),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const TaskCard(taskStatus: TaskStatus.sNew);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFloatingActionButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSingleChildScrollView() {
    return SingleChildScrollView(
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

  Future<void> _getAllTaskStatusCount() async {
    setState(() {
      _isLoading = true;
    });
    final NetworkResponse response = await NetworkClient.getRequest(
      url: Urls.taskStatusCount,
    );
    setState(() {
      _isLoading = false;
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

  void _onTapFloatingActionButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
    );
  }
}
