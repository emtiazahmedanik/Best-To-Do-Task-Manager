import 'package:besttodotask/screen/onboarding/forgotPasswordEmailVerificationScreen.dart';
import 'package:besttodotask/screen/onboarding/registrationScreen.dart';
import 'package:besttodotask/screen/task/mainBottomNavScreen.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

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
                  Text('Get Started With',style: Theme.of(context).textTheme.titleLarge,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),

                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password'
                    ),
                  ),
                  ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),

                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: _onTapForgotPassword,
                            child: const Text('Forgot Password ?',style: TextStyle(color: Colors.black),)
                        ),
                        RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Don't have account ?",style: TextStyle(color: Colors.black54) ),
                                TextSpan(
                                    text: " Sign Up",
                                    style: TextStyle(color: Colors.green),
                                    recognizer: TapGestureRecognizer()..onTap = _onTapSignUp
                                )
                              ]
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
  void _onTapSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Registrationscreen()));
  }

  void _onTapForgotPassword(){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>Emailverificationscreen()));
  }
  void _onTapSubmitButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MainBottomNavScreen()), (pre)=>false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


