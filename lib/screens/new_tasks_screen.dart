import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/controller/new_task_controller.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/task_count.dart';
import 'package:task_manager/model/task_count_summary_list_model.dart';
import 'package:task_manager/screens/add_new_task_screen.dart';
import '../data/utility/urls.dart';
import '../widget/profile_summary_card.dart';
import '../widget/summary_card.dart';
import '../widget/tesk_ltem_card.dart';

class NewTasksScreen extends StatefulWidget {
  const NewTasksScreen({super.key});

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskCountSummaryInProgress = false;

  TaskCountSummaryListModel taskCountSummaryListModel = TaskCountSummaryListModel();

  Future<void> getTaskCountSummaryList() async {
    getTaskCountSummaryInProgress = true;
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    if (response.isSuccess) {
      taskCountSummaryListModel = TaskCountSummaryListModel.fromJson(response.jsonResponse!);
    }
    getTaskCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );

          if (response != null && response == true) {
            Get.find<NewTaskController>().getNewTaskList();
            getTaskCountSummaryList();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummaryCard(),
            Visibility(
              visible: getTaskCountSummaryInProgress == false &&
                  (taskCountSummaryListModel.taskCountList?.isNotEmpty ??
                      false),
              replacement: const LinearProgressIndicator(),
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    taskCountSummaryListModel.taskCountList?.length ?? 0,
                    itemBuilder: (context, index) {
                      TaskCount taskCount =
                      taskCountSummaryListModel.taskCountList![index];
                      return FittedBox(
                        child: SummaryCard(
                          count: taskCount.sum.toString(),
                          title: taskCount.sId ?? '',
                        ),
                      );
                    }),
              ),
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.getNewTaskProgress == false,
                    replacement: const Center(child: CircularProgressIndicator()),
                    child: RefreshIndicator(
                      onRefresh: ()=>newTaskController.getNewTaskList(),
                      child: ListView.builder(
                        itemCount: newTaskController.taskListModel.taskList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return TaskItemCard(
                            task: newTaskController.taskListModel.taskList![index],
                            onStatusChange: () {
                              newTaskController.getNewTaskList();
                            },
                            showProgress: (inProgress) {
                            },
                          );
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}