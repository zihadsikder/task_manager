import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/model/task_list_model.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../widget/profile_summary_card.dart';
import '../widget/tesk_ltem_card.dart';

class CompletedTasksScreeen extends StatefulWidget {
  const CompletedTasksScreeen({super.key});

  @override
  State<CompletedTasksScreeen> createState() => _CompletedTasksScreeenState();
}

class _CompletedTasksScreeenState extends State<CompletedTasksScreeen> {
  bool getCompleteTask = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getCompleteTask = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCompleteTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
    getCompleteTask = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const ProfileSummaryCard(),
              Expanded(
                child: Visibility(
                  visible: getCompleteTask == false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: RefreshIndicator(
                    onRefresh: getProgressTaskList,
                    child: ListView.builder(
                      itemCount: taskListModel.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskItemCard(
                          task: taskListModel.taskList![index],
                          onStatusChange: () {
                            getProgressTaskList();
                          },
                          showProgress: (Complete) {
                            getCompleteTask = Complete;
                            if (mounted) {
                              setState(() {});
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}