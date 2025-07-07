import 'package:besttodotask/data/service/networkClient.dart';
import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  bool _obscure = true;

  get getObscureNewPass => _obscure;

  set setObscureNewPass(value) {
    _obscure = value;
    update();
  }

  bool _obscureConfirmPassword = true;

  get getObscureConfirmPass => _obscureConfirmPassword;

  set setObscureConfirmPass(value) {
    _obscureConfirmPassword = value;
    update();
  }

  String? _errorMsg;

  get getErrorMsg => _errorMsg;

  bool isSuccess = false;

  Future<bool> onTapSubmit({
    required Map<String, dynamic> body,
    required url,
  }) async {
    _isLoading = true;
    update();

    NetworkResponse response = await NetworkClient.postRequest(
      url: url,
      body: body,
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
