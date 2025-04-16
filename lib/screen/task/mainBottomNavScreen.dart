import 'package:besttodotask/screen/task/cancelledTaskListScreen.dart';
import 'package:besttodotask/screen/task/completedTaskListScreen.dart';
import 'package:besttodotask/screen/task/newTaskListScreen.dart';
import 'package:besttodotask/screen/task/progressTaskListScreen.dart';
import 'package:besttodotask/widgets/tmAppBar.dart';
import 'package:flutter/material.dart';


class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens =const [
    NewTaskListScreen(),
    ProgressTaskListScreen(),
    CompletedTaskListScreen(),
    CancelledTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black12,
          indicatorColor: Colors.green,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations:const [
            NavigationDestination(icon: Icon(Icons.fiber_new), label: 'New'),
            NavigationDestination(icon: Icon(Icons.incomplete_circle_outlined), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done_all_sharp), label: 'Completed'),
            NavigationDestination(icon: Icon(Icons.cancel_presentation), label: 'Cancelled')
          ]
      ),
    );
  }
}

