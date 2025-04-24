import 'dart:convert';

import 'package:besttodotask/screen/controller/authController.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.data,
    required this.errorMessage,
  });
}

class NetworkClient {
  static final Logger _logger = Logger();


  static Future<NetworkResponse> getRequest({required String url}) async {
    {
      try {
        Uri uri = Uri.parse(url);
        Map<String,String> headers = {
          "token":AuthController.token ?? ''
        };
        Response response = await get(uri,headers: headers);
        _preRequestLogging(url: url, body: response.body);
        if (response.statusCode == 200) {
          final decodedJson = jsonDecode(response.body);
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson,
            errorMessage: ""
          );
        } else {
          final decodedJson = jsonDecode(response.body);
          String errorMsg = decodedJson["data"] ?? "Something wrong";
          _logger.e(errorMsg);
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMsg,
          );
        }
      } on Exception catch (e) {
        _logger.e(e.toString());
        return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: e.toString(),
        );
      }
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body,}) async {
    {
      try {
        Uri uri = Uri.parse(url);
        Map<String,String> headers = {
          "token":AuthController.token ?? '',
          'content-type': 'application/json'
        };
        Response response = await post(
          uri,
          headers: headers,
          body: jsonEncode(body),
        );
        _postRequestLogging(
          url: url,
          body: response.body,
          statusCode: response.statusCode,
          headers: headers
        );
        if (response.statusCode == 200) {
          final decodedJson = jsonDecode(response.body);
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            data: decodedJson,
            errorMessage: ""
          );
        } else {
          final decodedJson = jsonDecode(response.body);
          String errorMsg = decodedJson["data"] ?? "Something wrong";
          _logger.e(errorMsg);
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: errorMsg
          );
        }
      } on Exception catch (e) {
        _logger.e(e.toString());
        return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: e.toString(),
        );
      }
    }
  }

  static void _preRequestLogging({required String url, String? body}) {
    _logger.i("Url=>$url \n Response Body=>$body");
  }

  static void _postRequestLogging({
    String? url,
    String? body,
    int? statusCode,
    Map<String,String>? headers
  }) {
    _logger.i("Url=>$url \nstatusCode=>$statusCode \n Response Body=>$body \n header: $headers");
  }
}
