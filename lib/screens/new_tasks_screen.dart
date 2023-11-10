import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_new_task_screen.dart';

import '../widget/profile_summary_card.dart';
import '../widget/summary_card.dart';
import '../widget/tesk_ltem_card.dart';

class NewTasksScreeen extends StatefulWidget {
  const NewTasksScreeen({super.key});

  @override
  State<NewTasksScreeen> createState() => _NewTasksScreeenState();
}

class _NewTasksScreeenState extends State<NewTasksScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
          },

          child: const Icon(Icons.add,),
        ),
        body: SafeArea(
      child: Column(
        children: [
          ProfileSummaryCard(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                children: [
                  SummaryCard(
                    count: '92',
                    title: 'New',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'In Progress',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'Completed',
                  ),
                  SummaryCard(
                    count: '92',
                    title: 'Cancelled',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount:5 ,
            itemBuilder: (context, index) {
              return const TaskItemCard();
            },
          ),
          ),
        ],
      ),
    ),
    );
  }
}


