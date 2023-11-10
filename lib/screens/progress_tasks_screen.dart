import 'package:flutter/material.dart';

import '../widget/profile_summary_card.dart';
import '../widget/tesk_ltem_card.dart';

class ProgressTasksScreeen extends StatefulWidget {
  const ProgressTasksScreeen({super.key});

  @override
  State<ProgressTasksScreeen> createState() => _ProgressTasksScreeenState();
}

class _ProgressTasksScreeenState extends State<ProgressTasksScreeen> {
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
