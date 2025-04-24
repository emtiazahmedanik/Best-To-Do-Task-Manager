import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/screen/onboarding/setPasswordScreen.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../widgets/screenBackground.dart';

class Pinverificationscreen extends StatefulWidget {
  final String email;

  const Pinverificationscreen({super.key, required this.email});

  @override
  State<Pinverificationscreen> createState() =>
      _PinverificationscreenState(this.email);
}

class _PinverificationscreenState extends State<Pinverificationscreen> {
  final _pinCodeController = TextEditingController();
  late TapGestureRecognizer _signInRecognizer;
  final String email;

  _PinverificationscreenState(this.email);

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signInRecognizer = TapGestureRecognizer()..onTap = _onTapSignIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text('PIN Verification', style: TextTheme.of(context).titleLarge),
              Text(
                'A 6 digit verification pin will be sent to your email.',
                style: TextTheme.of(
                  context,
                ).bodyLarge!.copyWith(color: Colors.grey),
              ),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.green.shade100,
                ),
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                controller: _pinCodeController,
                onCompleted: (v) {},
                appContext: context,
              ),
              Visibility(
                visible: !_isLoading,
                child: ElevatedButton(
                  onPressed: _onTapVerifyButton,
                  child: const Text('Verify'),
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
                        recognizer: _signInRecognizer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
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

  Future<void> _onTapVerifyButton() async {
    setState(() {
      _isLoading = true;
    });
    final String otp = _pinCodeController.text;
    final String url = "${Urls.recoverOTP}/$email/$otp";
    NetworkResponse response = await NetworkClient.getRequest(url: url);
    setState(() {
      _isLoading = false;
    });
    if (response.isSuccess) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Setpasswordscreen(email: email, OTP: otp),
        ),
      );
    } else {
      showSnakeBarMessage(
        context: context,
        message: response.errorMessage,
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pinCodeController.dispose();
    _signInRecognizer.dispose();
    super.dispose();
  }
}
