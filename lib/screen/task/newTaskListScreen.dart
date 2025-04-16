import 'package:besttodotask/screen/task/addNewTaskScreen.dart';
import 'package:besttodotask/widgets/summaryTask.dart';
import 'package:besttodotask/widgets/taskCard.dart';
import 'package:flutter/material.dart';



class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
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
              itemBuilder: (context,index){
                return const TaskCard(taskStatus: TaskStatus.sNew,);
              },
              separatorBuilder: (context, index){
                return const SizedBox(height: 8,);
              },
            
            )
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
            child: Row(
              children: [
                SummaryTask(title: 'New',count: 12,),
                SummaryTask(title: 'Progress',count: 12,),
                SummaryTask(title: 'Completed',count: 12,),
                SummaryTask(title: 'Cancelled',count: 12,)
              ],
            ),
          ),
        );
  }

  void _onTapFloatingActionButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNewTaskScreen()));
  }
}



