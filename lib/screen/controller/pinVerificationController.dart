import 'package:besttodotask/data/service/networkClient.dart';
import 'package:get/get.dart';

class PinVerificationController extends GetxController {
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  bool isSuccess = false;
  String? _errorMsg;

  get getErrorMsg => _errorMsg;

  Future<bool> onTapVerifyButton({required otp, required url}) async {
    _isLoading = true;
    update();
    NetworkResponse response = await NetworkClient.getRequest(url: url);

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
