import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/task_list_model.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/widget/profile_summary_card.dart';
import 'package:task_manager/widget/tesk_ltem_card.dart';

class CancelledTasksScreeen extends StatefulWidget {
  const CancelledTasksScreeen({super.key});

  @override
  State<CancelledTasksScreeen> createState() => _CancelledTasksScreeenState();
}

class _CancelledTasksScreeenState extends State<CancelledTasksScreeen> {
  bool getCancelledTaskComplete = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getProgressTaskList() async {
    getCancelledTaskComplete = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getCancelledTasks);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse!);
    }
    getCancelledTaskComplete = false;
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
                  visible: getCancelledTaskComplete == false,
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
                            getCancelledTaskComplete = Complete;
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