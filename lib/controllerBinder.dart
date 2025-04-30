import 'package:besttodotask/screen/controller/addNewTaskController.dart';
import 'package:besttodotask/screen/controller/emailVerificationController.dart';
import 'package:besttodotask/screen/controller/loginController.dart';
import 'package:besttodotask/screen/controller/pinVerificationController.dart';
import 'package:besttodotask/screen/controller/profileUpdateController.dart';
import 'package:besttodotask/screen/controller/registrationController.dart';
import 'package:besttodotask/screen/controller/setPasswordController.dart';
import 'package:besttodotask/screen/controller/taskListController.dart';
import 'package:besttodotask/screen/controller/taskStatusCountController.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(TaskStatusCountController());
    Get.put(TaskListController());
    Get.put(RegistrationController());
    Get.put(EmailVerificationController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
    Get.put(ProfileUpdateController());
    Get.put(AddNewTaskController());

  }

}