import '../../widget/tesk_ltem_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static String getNewTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.New.name}';
  static String getProgressTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCompleteTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancelledTasks = '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';

  static String updateTaskStatus(String taskId, String status) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';
  static const String updateProfile = '$_baseUrl/profileUpdate';
  static const String deleteTask = '$_baseUrl/deleteTask';

  static const String recoveryVerifyEmail = '$_baseUrl/RecoverVerifyEmail';
  static const String recoveryVerifyOTP = '$_baseUrl/RecoverVerifyOTP';
  static const String recoveryResetPass = '$_baseUrl/RecoverResetPass';
}