
import 'package:besttodotask/screen/controller/loginController.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    String? email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return "Enter email";
                    }
                    return null;
                  },
                ),
                GetBuilder<LoginController>(
                  builder: (_) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      obscureText: _loginController.getObscure,
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
                GetBuilder<LoginController>(
                  builder: (_) {
                    return Visibility(
                      visible: _loginController.getIsLoading == false,
                      replacement: Center(
                        child: SquareProgressIndicator(
                          color: Colors.green,
                          height: 34,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _onTapSubmitButton,
                        child: Icon(Icons.arrow_circle_right_outlined),
                      ),
                    );
                  }
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTapForgotPassword,
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have account ?",
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(
                              text: " Sign Up",
                              style: TextStyle(color: Colors.green),
                              recognizer:
                                  TapGestureRecognizer()..onTap = _onTapSignUp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildObscureButton() {
    return GetBuilder<LoginController>(
      builder: (GetxController controller) {
        return IconButton(
          onPressed: () {
            _loginController.setObscure = !_loginController.getObscure;
          },
          icon:
              _loginController.getObscure
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye_outlined, color: Colors.red),
        );
      },
    );
  }

  void _onTapSignUp() {
    Get.toNamed("/RegistrationScreen");

  }

  void _onTapForgotPassword() {
    Get.toNamed("/EmailVerificationScreen");

  }

  void _onTapSubmitButton() {
    _logInUser();
  }

  Future<void> _logInUser() async {
    if (_globalKey.currentState!.validate()) {
      final bool isSuccess = await _loginController.logInUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (isSuccess) {
        Get.offAllNamed("/MainBottomNavScreen");
        showSnakeBarMessage(context: context, message: "Login Successful");
      } else {
        showSnakeBarMessage(
          context: context,
          message: _loginController.getErrorMsg!,
          isError: true,
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
