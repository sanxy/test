import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:test/api/api_response.dart';
import 'package:test/api/api_response_type.dart';
import '../utils/tools.dart';


///POST REQUEST
Future<ApiResponse> postRequest({
  required String route,
  required Map<String, dynamic> payload,
  bool isAuthorized = true,
}) async {
  try {
    var response = await http
        .post(Uri.parse(route),
            headers: {
              "Accept": "application/json",
             "Content-Type": "application/json",
              // if (isAuthorized) "Authorization": "Bearer ${StorageService().getString('token')}"
            },
            body: jsonEncode(payload))
        .timeout(const Duration(seconds: 60));

    dPrint('statusCode::: ${response.statusCode}');
    dPrint('response::: ${response.body}');
    //success
    if ((response.statusCode == 200 || response.statusCode == 201)) {
      dPrint('request successful:::');
      return ApiResponse(type: ApiResponseType.success, response: response.body);
    }
    //failure
    else {
      dPrint('request failed:::');
      return ApiResponse(type: ApiResponseType.failed, response: response.body);
    }
  } on SocketException {
    dPrint('socket exception:::');
    return ApiResponse(type: ApiResponseType.server, response: null);
  } catch (e) {
    dPrint('exception::: $e');
    return ApiResponse(type: ApiResponseType.exception, response: null);
  }
}

///GET REQUEST
Future<ApiResponse> getRequest({
  required String route,
  bool isAuthorized = true,
}) async {
  try {
    var response = await http.get(Uri.parse(route), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // if (isAuthorized) "Authorization": "Bearer ${StorageService().getString('token')}"
    }).timeout(const Duration(seconds: 60));

    dPrint('statusCode::: ${response.statusCode}');
    dPrint('response::: ${response.body}');

    //success
    if ((response.statusCode == 200 || response.statusCode == 201)) {
      dPrint('request successful:::');
      return ApiResponse(type: ApiResponseType.success, response: response.body);
    }
    //failure
    else {
      dPrint('request failed:::');
      return ApiResponse(type: ApiResponseType.failed, response: response.body);
    }
  } on SocketException {
    dPrint('socket exception:::');
    return ApiResponse(type: ApiResponseType.server, response: null);
  } catch (e) {
    dPrint('exception::: $e');
    return ApiResponse(type: ApiResponseType.exception, response: null);
  }
}
