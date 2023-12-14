// import 'package:get/get.dart';
// import 'package:task_manager/data/network_caller.dart';
// import 'package:task_manager/data/network_response.dart';
// import 'package:task_manager/data/utility/urls.dart';
//
// import '../model/user_models.dart';
// import 'auth_controller.dart';
//
// class EditProfileController extends GetxController {
//   bool _updateProfileInProgress = false;
//
//   String _failMassage = '';
//
//   String get failerMassage => _failMassage;
//
//   bool get updateProfileInProgress => _updateProfileInProgress;
//
//   Future<bool> updateProfile(
//       String firstName, String lastName, String email, String mobile) async {
//     Map<String, dynamic> inputData = {
//       "firstName": firstName,
//       "lastName": lastName,
//       "email": email,
//       "mobile": mobile,
//     };
//     final NetworkResponse response = await NetworkCaller().postRequest(
//       Urls.updateProfile,
//       body: inputData,
//     );
//     _updateProfileInProgress = true;
//     update();
//     if (response.isSuccess) {
//       AuthController.updateUserInformation(UserModel(
//         email: email,
//         firstName: firstName,
//         lastName: lastName,
//         mobile: mobile,
//       ));
//       if (response.statusCode == 401) {
//         _failMassage = ('Update profile success!');
//       }
//     } else {
//       _failMassage = ('Update profile failed. Try again.');
//     }
//     return true;
//   }
// }
import 'package:get/get.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/network_response.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../model/user_models.dart';
import 'auth_controller.dart';

class EditProfileController extends GetxController {
  RxBool updateProfileInProgress = false.obs;

  String failMessage = '';

  Future<bool> updateProfile(
      String firstName, String lastName, String email, String mobile) async {
    updateProfileInProgress.value = true;
    update();

    Map<String, dynamic> inputData = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "mobile": mobile,
    };

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.updateProfile,
      body: inputData,
    );

    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
      ));

      if (response.statusCode == 401) {
        failMessage = 'Update profile success!';
      }
    } else {
      failMessage = 'Update profile failed. Try again.';
    }

    updateProfileInProgress.value = false;
    update();

    return true;
  }
}
