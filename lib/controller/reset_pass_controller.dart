import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class ResetPassController extends GetxController{
  final TextEditingController _passwordTEController = TextEditingController();
  String _failmessage ='';
  String get failerMessage => _failmessage;
  Future<bool> resetPassController(String resetPassController) async {
    String val = resetPassController;
    if(val.isEmpty){
      _failmessage = ('password not match');
      return true;
    }
    var widget;
    final response = await NetworkCaller()
        .postRequest(Urls.recoveryResetPass,body: {"email":widget.email,"OTP":widget.otp,"password": _passwordTEController.text},);
    if (response.isSuccess) {
     resetPassController;
    }else{
      _failmessage = ('Error : ${response.statusCode}');
      return true;
    }
   return true;
  }
}