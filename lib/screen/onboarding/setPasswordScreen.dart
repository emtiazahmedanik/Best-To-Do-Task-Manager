import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import '../../widgets/screenBackground.dart';
import 'loginScreen.dart';

class Setpasswordscreen extends StatefulWidget {
  final String email;
  final String OTP;

  const Setpasswordscreen({super.key, required this.email, required this.OTP});

  @override
  State<Setpasswordscreen> createState() =>
      _SetpasswordscreenState(this.email, this.OTP);
}

class _SetpasswordscreenState extends State<Setpasswordscreen> {

  final String email;
  final String OTP;

  _SetpasswordscreenState(this.email, this.OTP);

  final _setPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  Text('Set Password', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,),
                  Text(
                    'Minimum 8 character with letter and number combination.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey),),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _setPasswordController,
                    decoration: InputDecoration(
                        hintText: 'New Password'
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || (value!.length < 6)) {
                        return "Enter password at least 6 character";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                    validator: (String? value) {
                      if (value != _setPasswordController.text) {
                        return "Password did not matched!";
                      }
                      return null;
                    },
                  ),
                  Visibility(
                    visible: !_isLoading,
                    child: ElevatedButton(
                      onPressed: _onTapSubmit,
                      child: const Text(
                        'Confirm', style: TextStyle(color: Colors.white),),

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
                                  text: "Have an account?", style: TextStyle(
                                  color: Colors.black54)),
                              TextSpan(
                                  text: " Sign In",
                                  style: TextStyle(color: Colors.green),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _onTapSignIn
                              )
                            ]
                        )
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  void _onTapSignIn() {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => const Loginscreen()), (
        pre) => false);
  }

  Future<void> _onTapSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final String url = Urls.recoverResetPassword;
      Map<String, dynamic> body = {
        "email": email,
        "OTP": OTP,
        "password": _confirmPasswordController.text
      };
      NetworkResponse response = await NetworkClient.postRequest(
          url: url, body: body);

      setState(() {
        _isLoading = false;
      });
      if (response.isSuccess) {
        showSnakeBarMessage(context: context, message: "Password Changed");
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>const Loginscreen()),
            (pre) => false);
      }else{
        showSnakeBarMessage(context: context, message: "Something went wrong",isError: true);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _setPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
