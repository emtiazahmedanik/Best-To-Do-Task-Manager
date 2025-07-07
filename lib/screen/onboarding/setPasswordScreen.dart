
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/setPasswordController.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class Setpasswordscreen extends StatefulWidget {
  const Setpasswordscreen({super.key});

  @override
  State<Setpasswordscreen> createState() => _SetpasswordscreenState();
}

class _SetpasswordscreenState extends State<Setpasswordscreen> {
  final String? email = Get.parameters['email'];
  final String? OTP = Get.parameters['otp'];

  final _setPasswordTextEditController = TextEditingController();
  final _confirmPasswordTextEditController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _setPasswordController = Get.find<SetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
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
                Text(
                  'Set Password',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Minimum 8 character with letter and number combination.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                ),
                GetBuilder<SetPasswordController>(
                  builder: (_) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _setPasswordTextEditController,
                      obscureText: _setPasswordController.getObscureNewPass,
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        suffixIcon: buildObscureButton(),
                      ),
                      validator: (String? value) {
                        if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                          return "Enter password at least 6 character";
                        }
                        return null;
                      },
                    );
                  },
                ),
                GetBuilder<SetPasswordController>(
                  builder: (_) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordTextEditController,
                      obscureText: _setPasswordController.getObscureConfirmPass,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: buildObscureConfirmButton(),
                      ),
                      validator: (String? value) {
                        if (value != _setPasswordTextEditController.text) {
                          return "Password did not matched!";
                        }
                        return null;
                      },
                    );
                  },
                ),
                GetBuilder<SetPasswordController>(
                  builder: (context) {
                    return Visibility(
                      visible: _setPasswordController.getIsLoading == false,
                      replacement: Center(
                        child: SquareProgressIndicator(
                          color: Colors.green,
                          height: 34,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _onTapSubmit,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),

                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Have an account?",
                          style: TextStyle(color: Colors.black54),
                        ),
                        TextSpan(
                          text: " Sign In",
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

  Widget buildObscureButton() {
    return GetBuilder<SetPasswordController>(
      builder: (GetxController controller) {
        return IconButton(
          onPressed: () {
            _setPasswordController.setObscureNewPass =
                !_setPasswordController.getObscureNewPass;
          },
          icon:
              _setPasswordController.getObscureNewPass
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye_outlined, color: Colors.red),
        );
      },
    );
  }

  Widget buildObscureConfirmButton() {
    return GetBuilder<SetPasswordController>(
      builder: (GetxController controller) {
        return IconButton(
          onPressed: () {
            _setPasswordController.setObscureConfirmPass =
                !_setPasswordController.getObscureConfirmPass;
          },
          icon:
              _setPasswordController.getObscureConfirmPass
                  ? Icon(Icons.remove_red_eye_outlined)
                  : Icon(Icons.remove_red_eye_outlined, color: Colors.red),
        );
      },
    );
  }

  void _onTapSignIn() {
    Get.offAllNamed("/LoginScreen");
    // Navigator.pushAndRemoveUntil(
    //     context, MaterialPageRoute(builder: (context) => const Loginscreen()), (
    //     pre) => false);
  }

  Future<void> _onTapSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String url = Urls.recoverResetPassword;
      Map<String, dynamic> body = {
        "email": email,
        "OTP": OTP,
        "password": _confirmPasswordTextEditController.text,
      };
      final isSuccess = await _setPasswordController.onTapSubmit(
        body: body,
        url: url,
      );
      if (isSuccess) {
        showSnakeBarMessage(context: context, message: "Password Changed");
        Get.offAllNamed("/LoginScreen");
      } else {
        showSnakeBarMessage(
          context: context,
          message: _setPasswordController.getErrorMsg,
          isError: true,
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _setPasswordController.dispose();
    _confirmPasswordTextEditController.dispose();
    super.dispose();
  }
}
