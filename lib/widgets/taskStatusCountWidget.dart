import 'package:besttodotask/screen/controller/taskStatusCountController.dart';
import 'package:besttodotask/widgets/summaryTask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

final _taskStatusCountController = Get.find<TaskStatusCountController>();

Widget buildTaskListCountView() {
  return Stack(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            child: GetBuilder<TaskStatusCountController>(
              builder: (_) {
                return ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _taskStatusCountController.getTaskCountList.length,
                  itemBuilder: (context, index) {
                    return SummaryTask(
                      title:
                          _taskStatusCountController
                              .getTaskCountList[index]
                              .status,
                      count:
                          _taskStatusCountController
                              .getTaskCountList[index]
                              .count,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      GetBuilder<TaskStatusCountController>(
        builder: (_) {
          return _taskStatusCountController.getIsStatusCountLoading
              ? Center(child: SquareProgressIndicator(color: Colors.green.shade50))
              : SizedBox.shrink();
        },
      ),
    ],
  );
}
