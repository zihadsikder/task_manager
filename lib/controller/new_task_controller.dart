import 'package:get/get.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/model/task_list_model.dart';

class NewTaskController extends GetxController{
  TaskListModel _taskListModel = TaskListModel();
  bool _getNewTaskInProgress = false;

  bool get getNewTaskProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
   update();
    final NetworkResponse response = await NetworkCaller().getRequest(Urls.getNewTasks);
    _getNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse!);
     isSuccess = true;
    }
    update();
    return isSuccess;
  }
}