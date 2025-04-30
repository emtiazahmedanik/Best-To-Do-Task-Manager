
import 'package:besttodotask/controllerBinder.dart';
import 'package:besttodotask/screen/onboarding/forgotPasswordEmailVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/forgotPasswordPinVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/screen/onboarding/registrationScreen.dart';
import 'package:besttodotask/screen/onboarding/setPasswordScreen.dart';
import 'package:besttodotask/screen/onboarding/splashScreen.dart';
import 'package:besttodotask/screen/profile/profileUpdateScreen.dart';
import 'package:besttodotask/screen/task/addNewTaskScreen.dart';
import 'package:besttodotask/screen/task/cancelledTaskListScreen.dart';
import 'package:besttodotask/screen/task/completedTaskListScreen.dart';
import 'package:besttodotask/screen/task/mainBottomNavScreen.dart';
import 'package:besttodotask/screen/task/newTaskListScreen.dart';
import 'package:besttodotask/screen/task/progressTaskListScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page:()=> Splashscreen()),
        GetPage(name: "/AddNewTaskScreen", page: ()=> AddNewTaskScreen()),
        GetPage(name: "/CancelledTaskScreen", page: ()=> CancelledTaskListScreen()),
        GetPage(name: "/CompletedTaskScreen", page: ()=> CompletedTaskListScreen()),
        GetPage(name: "/MainBottomNavScreen", page: ()=> MainBottomNavScreen()),
        GetPage(name: "/NewTaskScreen", page: ()=> NewTaskListScreen()),
        GetPage(name: "/ProgressTaskScreen", page: ()=> ProgressTaskListScreen()),
        GetPage(name: "/ProfileUpdateScreen", page: ()=> ProfileUpdateScreen()),
        GetPage(name: "/RegistrationScreen", page: ()=> Registrationscreen()),
        GetPage(name: "/LoginScreen", page: ()=> Loginscreen()),
        GetPage(name: "/EmailVerificationScreen", page: ()=> Emailverificationscreen()),
        GetPage(name: "/PinVerificationScreen", page: ()=> Pinverificationscreen()),
        GetPage(name: "/SetPasswordScreen", page: ()=> Setpasswordscreen())

      ],
      initialBinding: ControllerBinder(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "poppins",
        colorSchemeSeed: Colors.green.shade500,
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey
            ),
            border: _getOutlineBorder(),
            enabledBorder: _getOutlineBorder(),
            errorBorder: _getOutlineBorder()
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),

        )
      ),
      home: Splashscreen(),
    );
  }

  OutlineInputBorder _getOutlineBorder(){
    return const OutlineInputBorder(
        borderSide: BorderSide.none
    );
  }
}
