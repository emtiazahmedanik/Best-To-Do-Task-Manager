import 'package:besttodotask/data/service/networkClient.dart';
import 'package:get/get.dart';

class AddNewTaskController extends GetxController {
  bool _isLoading = false;

  get getIsLoading => _isLoading;
  String? _errorMsg;

  get getErrorMsg => _errorMsg;

  bool isSuccess = false;

  Future<bool> addNewTask({required url, required Map<String,dynamic> requestBody}) async {
    _isLoading = true;
    update();
    final NetworkResponse response = await NetworkClient.postRequest(
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
