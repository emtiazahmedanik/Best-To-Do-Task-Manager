import 'package:besttodotask/data/model/loginModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool _obscure = true;
  void set setObscure(obs) {
    _obscure = obs;
    update();
  }
  bool get getObscure => _obscure;
  bool _isLoading = false;

  bool get getIsLoading => _isLoading;

  bool isSuccess = false;
  String? _errorMsg;

  String? get getErrorMsg => _errorMsg;

  Future<bool> logInUser({
    required String email,
    required String password,
  }) async {

      _isLoading = true;
      update();
      Map<String, dynamic> requestBody = {"email": email, "password": password};
      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.loginUrl,
        body: requestBody,
      );

      if (response.isSuccess) {
        LoginModel loginModel = LoginModel.fromJson(response.data!);
        await AuthController.saveUserInformation(
          loginModel.token,
          loginModel.userModel,
        );
        isSuccess = true;
        _errorMsg = null;
      } else {
        _errorMsg = response.errorMessage;
      }
      _isLoading = false;
      update();

    return isSuccess;
  }
}
