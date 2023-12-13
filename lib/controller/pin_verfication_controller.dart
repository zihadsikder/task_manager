import 'package:get/get.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class PinVerificationController extends GetxController{
  String _failmessage ='';
  String get failerMessage => _failmessage;
  Future<bool> CreateOTP (String otpController)async {
    String val = otpController;
    if(val.isEmpty){
      _failmessage = ('enter valid data');
      return true;
    }
    //widget.showProgress(true);
    var widget;
    final response = await NetworkCaller()
        .getRequest('${Urls.recoveryVerifyOTP}/${widget.email}/$val');
    if (response.isSuccess) {
     otpController;
    }
    else{
      _failmessage = ('Error : ${response.statusCode}');
      return true;
  
    }
    return false;
  }
}