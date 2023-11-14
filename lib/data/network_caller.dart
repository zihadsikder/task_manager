import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:task_manager/data/network_response.dart';

class NetworkCaller {
  Future <NetworkResponse> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      log(url);
      log(body.toString());
     final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'content-type': "Application/json"});

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      }
      else {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
