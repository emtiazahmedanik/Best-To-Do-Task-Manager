import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/onboarding/forgotPasswordPinVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Emailverificationscreen extends StatefulWidget {
  const Emailverificationscreen({super.key});

  @override
  State<Emailverificationscreen> createState() =>
      _EmailverificationscreenState();
}

class _EmailverificationscreenState extends State<Emailverificationscreen> {
  final _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  'Your Email Address',
                  style: TextTheme.of(context).titleLarge,
                ),
                Text(
                  'A 6 digit verification pin will be sent to your email.',
                  style: TextTheme.of(
                    context,
                  ).bodyLarge!.copyWith(color: Colors.grey),
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    String? email = value?.trim() ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
                Visibility(
                  visible: !_isLoading,
                  child: ElevatedButton(
                    onPressed: _onTabSubmit,
                    child:Icon(Icons.arrow_circle_right_outlined),
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
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Have Account?',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: ' Sign In',
                          style: TextStyle(color: Colors.green),
                          recognizer:
                              TapGestureRecognizer()..onTap = _onTapSignIn,
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
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
      (pre) => false,
    );
  }

  Future<void> _onTabSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final email = _emailController.text.trim();
      final url = "${Urls.recoverEmail}/$email";
      NetworkResponse response = await NetworkClient.getRequest(url: url);
      setState(() {
        _isLoading = false;
      });
      if (response.isSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pinverificationscreen(email: email),
          ),
        );
      } else {
        showSnakeBarMessage(
          context: context,
          message: "Something went wrong",
          isError: true,
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
}
