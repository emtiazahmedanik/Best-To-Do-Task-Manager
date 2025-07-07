import 'package:besttodotask/data/service/networkClient.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProfileUpdateController extends GetxController {
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  String? _errorMsg;

  get getErrorMsg => _errorMsg;

  bool isSuccess = false;

  Future<bool> onTapSubmit({required Map<String, dynamic> requestBody, required url}) async {
    _isLoading = true;
    update();
    NetworkResponse response = await NetworkClient.postRequest(
      url: url,
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
