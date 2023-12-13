import 'package:get/get.dart';
import 'package:task_manager/controller/auth_controller.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../model/user_models.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _failMassage = '';

  bool get loginInProgress => _loginInProgress;

  String get failureMessage => _failMassage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login, body: {
      'email': email,
      'password': password,
    });
    _loginInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse?['token'],
          UserModel.fromJson(response.jsonResponse?['data']));
      return true;
    } else {
      if (response.statusCode == 401) {
        _failMassage = ('Please check email/password');
      } else {
        _failMassage = ('Login failed. Try again');
      }
    }
    return false;
  }
}
