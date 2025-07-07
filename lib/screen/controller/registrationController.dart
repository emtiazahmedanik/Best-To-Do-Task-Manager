import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  bool _obscure = true;

  get getObscure => _obscure;

  set setObscure(value) {
    _obscure = value;
    update();
  }

  String? _errorMsg;

  get getErrorMsg => _errorMsg;

  bool isSuccess = false;

  Future<bool> registerUser({
    required email,
    required firstName,
    required lastName,
    required mobile,
    required password,
  }) async {
    _isLoading = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
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
