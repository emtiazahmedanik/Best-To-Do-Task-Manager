import 'package:besttodotask/data/model/loginModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/authController.dart';
import 'package:besttodotask/screen/onboarding/forgotPasswordEmailVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/registrationScreen.dart';
import 'package:besttodotask/screen/task/mainBottomNavScreen.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  bool _obscure = true;
  bool _isLoading = false;

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
                  validator: (String? value){
                    String? email = value?.trim() ?? '';
                    if(EmailValidator.validate(email) == false){
                      return "Enter email";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: buildObscureButton(),
                  ),
                  validator: (String? value){
                    if((value?.isEmpty ?? true) || (value!.length<6)){
                      return "Enter password at least 6 character";
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: !_isLoading,
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: SquareProgressIndicator(
                      color: Colors.green,
                      height: 34,
                    ),
                  ),
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
    return IconButton(
      onPressed: () {
        _obscure = !_obscure;
        setState(() {});
      },
      icon:
          _obscure
              ? Icon(Icons.remove_red_eye_outlined)
              : Icon(Icons.remove_red_eye_outlined, color: Colors.red),
    );
  }

  void _onTapSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registrationscreen()),
    );
  }

  void _onTapForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Emailverificationscreen()),
    );
  }

  void _onTapSubmitButton() {
    _logInUser();
  }

  Future<void> _logInUser() async {
    if (_globalKey.currentState!.validate()) {
      _isLoading = true;

      setState(() {});
      Map<String, dynamic> requestBody = {
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
      };
      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.loginUrl,
        body: requestBody,
      );
      _isLoading = false;
      setState(() {});
      if (response.isSuccess) {
        LoginModel loginModel = LoginModel.fromJson(response.data!);
        //ToDo:save token to local
        AuthController.saveUserInformation(
            loginModel.token, loginModel.userModel);
        //ToDO: local database set up
        //ToDo: logged in/or not

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
              (pre) => false,
        );
        showSnakeBarMessage(context: context, message: "Login Successful");
      } else {
        showSnakeBarMessage(
            context: context, message: "Login error", isError: true);
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
