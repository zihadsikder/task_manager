import 'package:get/get.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

class AddNewTaskScreenController extends GetxController{
  bool _createTaskInProgress = false;
  String _failmessage ='';
  String get failerMessage => _failmessage;
  bool get createTaskInProgress => _createTaskInProgress;

  Future<bool> createTask(String subject, String description) async {
      _createTaskInProgress = true;
      update();
      final NetworkResponse response =
      await NetworkCaller().postRequest(Urls.createNewTask, body: {
        "title": subject,
        "description": description,
        "status": "New"
      });
      _createTaskInProgress = false;
      update();
      if (response.isSuccess) {
        subject;
        description;
        if(response.statusCode == 401) {
         _failmessage = ('New task added!');
        }
      } else {
          _failmessage = ( 'Create new task failed! Try again.');
      }

    return false;
  }

}