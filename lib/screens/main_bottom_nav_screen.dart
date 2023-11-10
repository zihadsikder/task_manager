import 'package:flutter/material.dart';
import 'package:task_manager/screens/cancelled_tasks_screen.dart';
import 'package:task_manager/screens/completed_tasks_screen.dart';
import 'package:task_manager/screens/new_tasks_screen.dart';
import 'package:task_manager/screens/progress_tasks_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  List<Widget> screens  = const [
    NewTasksScreeen(),
    ProgressTasksScreeen(),
    CompletedTasksScreeen(),
    CancelledTasksScreeen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
         _selectedIndex = index;
         setState(() {});
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'New'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Complate'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Cancelled'),
        ],
             ),
    );


  }
}
