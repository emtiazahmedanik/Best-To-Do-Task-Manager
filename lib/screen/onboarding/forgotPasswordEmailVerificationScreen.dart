import 'package:besttodotask/screen/onboarding/forgotPasswordPinVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Emailverificationscreen extends StatefulWidget {
  const Emailverificationscreen({super.key});

  @override
  State<Emailverificationscreen> createState() => _EmailverificationscreenState();
}

class _EmailverificationscreenState extends State<Emailverificationscreen> {

  final _emailController = TextEditingController();

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
                Text('Your Email Address',style: TextTheme.of(context).titleLarge,),
                Text('A 6 digit verification pin will be sent to your email.',style: TextTheme.of(context).bodyLarge!.copyWith(color: Colors.grey),),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email'
                  ),
                ),
                ElevatedButton(
                    onPressed: _onTabSubmit,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: 'Have Account?',style: TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: ' Sign In',style:
                              TextStyle(color: Colors.green),
                              recognizer: TapGestureRecognizer()..onTap = _onTapSignIn
                          )
                        ]
                      )
                  ),
                )
              ],
            ),
          )
      ),
    );
  }

  void _onTapSignIn(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Loginscreen()),(pre)=>false);
  }

  void _onTabSubmit(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const Pinverificationscreen()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }
}
