
import 'package:besttodotask/screen/controller/registrationController.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _registrationController = Get.find<RegistrationController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Join With Us',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return "Enter a valid Email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return "Enter first name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return "Enter last name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    controller: _mobileController,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    validator: (String? value) {
                      RegExp regEx = RegExp(r"^(?:\+88|88)?(01[3-9]\d{8})$");
                      String phone = value?.trim() ?? "";
                      if (regEx.hasMatch(phone) == false) {
                        return "Enter valid phone number";
                      }
                      return null;
                    },
                  ),
                  GetBuilder<RegistrationController>(
                    builder: (_) {
                      return TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        obscureText: _registrationController.getObscure,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: buildObscureButton(),
                        ),
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                            return "Enter password at least 6 character";
                          }
                          return null;
                        },
                      );
                    }
                  ),
                  GetBuilder<RegistrationController>(
                    builder: (_) {
                      return Visibility(
                        visible: _registrationController.getIsLoading == false,
                        replacement: Center(
                          child: SquareProgressIndicator(
                            color: Colors.green,
                            height: 34,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _onTapSubmit,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account ?",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextSpan(
                            text: " Sign In",
                            style: TextStyle(color: Colors.green),
                            recognizer:
                            TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildObscureButton() {
    return GetBuilder<RegistrationController>(
      builder: (GetxController controller) {
        return IconButton(
          onPressed: () {
            _registrationController.setObscure =
            !_registrationController.getObscure;
          },
          icon:
          _registrationController.getObscure
              ? Icon(Icons.remove_red_eye_outlined)
              : Icon(Icons.remove_red_eye_outlined, color: Colors.red),
        );
      },
    );
  }


  void _onTapSignInButton() {
    Get.back();
  }

  void _onTapSubmit() {
    if (_formKey.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    final isSuccess = await _registrationController.registerUser(
        email: _emailController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passwordController.text.trim());

    if (isSuccess) {
      Get.offAllNamed("/LoginScreen");
      showSnakeBarMessage(context: context, message: "Registration success");
    } else {
      showSnakeBarMessage(
        context: context,
        message: _registrationController.getErrorMsg,
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
