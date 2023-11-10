import 'package:flutter/material.dart';
import 'package:task_manager/widget/profile_summary_card.dart';
import 'package:task_manager/widget/tesk_ltem_card.dart';

class CancelledTasksScreeen extends StatefulWidget {
  const CancelledTasksScreeen({super.key});

  @override
  State<CancelledTasksScreeen> createState() => _CancelledTasksScreeenState();
}

class _CancelledTasksScreeenState extends State<CancelledTasksScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ProfileSummaryCard(),
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
        ));
  }
}
