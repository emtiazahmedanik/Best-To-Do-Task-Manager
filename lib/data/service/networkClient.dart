import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkResponse{
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage ;

  NetworkResponse({
        required this.isSuccess,
        required this.statusCode,
        this.data,
        this.errorMessage= "Something went wrong"
      });
}

class NetworkClient{
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest({required String url}) async{

    {
      try {
        Uri uri = Uri.parse(url);
        Response response = await get(uri);
        _preRequestLogging(url: url,body: response.body);
        if (response.statusCode == 200) {
          final decodedJson = jsonDecode(response.body);
          return NetworkResponse(isSuccess: true,
              statusCode: response.statusCode,
              data: decodedJson);
        } else {
          return NetworkResponse(
              isSuccess: false, statusCode: response.statusCode);
        }
      } on Exception catch (e) {
        _logger.e(e.toString());
        return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
      }
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async{

    {
      try {
        Uri uri = Uri.parse(url);
        Response response = await post(
          uri,
          headers: {'content-type':'application/json'},
          body: jsonEncode(body)
        );
        _postRequestLogging(url: url,body: response.body,statusCode: response.statusCode);
        if (response.statusCode == 200) {
          final decodedJson = jsonDecode(response.body);
          return NetworkResponse(isSuccess: true,
              statusCode: response.statusCode,
              data: decodedJson);
        } else {
          return NetworkResponse(
              isSuccess: false, statusCode: response.statusCode);
        }

      } on Exception catch (e) {
        _logger.e(e.toString());
        return NetworkResponse(isSuccess: false, statusCode: -1, errorMessage: e.toString());
      }
    }
  }

  static void _preRequestLogging({ required String url, String? body}){
    _logger.i(
      "Url=>$url \n Response Body=>$body"
    );
  }
  static void _postRequestLogging({ String? url, String? body,int? statusCode}){
    _logger.i(
        "Url=>$url \nstatusCode=>$statusCode \n Response Body=>$body"
    );
  }

}