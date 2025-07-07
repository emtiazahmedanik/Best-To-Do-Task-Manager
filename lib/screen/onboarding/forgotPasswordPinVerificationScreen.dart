
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/pinVerificationController.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';


class Pinverificationscreen extends StatefulWidget {


  const Pinverificationscreen({super.key});

  @override
  State<Pinverificationscreen> createState() =>
      _PinverificationscreenState();
}

class _PinverificationscreenState extends State<Pinverificationscreen> {
  final _pinCodeController = TextEditingController();
  late TapGestureRecognizer _signInRecognizer;
  final _pinVerificationController = Get.find<PinVerificationController>();

  final  _email = Get.arguments;

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
              GetBuilder<PinVerificationController>(
                builder: (_) {
                  return Visibility(
                    visible: _pinVerificationController.getIsLoading == false,
                    replacement: Center(
                      child: SquareProgressIndicator(
                        color: Colors.green,
                        height: 34,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: _onTapVerifyButton,
                      child: const Text('Verify'),
                    ),
                  );
                }
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
    Get.offAllNamed("/LoginScreen");
    // Navigator.pushAndRemoveUntil(
    //   context,
    //   MaterialPageRoute(builder: (context) => const Loginscreen()),
    //   (pre) => false,
    // );
  }

  Future<void> _onTapVerifyButton() async {

    final String otp = _pinCodeController.text;
    final String url = "${Urls.recoverOTP}/$_email/$otp";
    final isSuccess = await _pinVerificationController.onTapVerifyButton(otp: otp, url: url);
    if (isSuccess) {

      Get.toNamed("/SetPasswordScreen?otp=$otp&email=$_email");
    } else {
      showSnakeBarMessage(
        context: context,
        message: _pinVerificationController.getErrorMsg,
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    _signInRecognizer.dispose();
    super.dispose();
  }
}
