import 'package:flutter/material.dart';

import '../widget/profile_summary_card.dart';
import '../widget/tesk_ltem_card.dart';

class CompletedTasksScreeen extends StatefulWidget {
  const CompletedTasksScreeen({super.key});

  @override
  State<CompletedTasksScreeen> createState() => _CompletedTasksScreeenState();
}

class _CompletedTasksScreeenState extends State<CompletedTasksScreeen> {
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
