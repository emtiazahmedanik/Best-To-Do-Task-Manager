import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/screenBackground.dart';
import 'loginScreen.dart';

class Setpasswordscreen extends StatefulWidget {
  const Setpasswordscreen({super.key});

  @override
  State<Setpasswordscreen> createState() => _SetpasswordscreenState();
}

class _SetpasswordscreenState extends State<Setpasswordscreen> {
  final _setPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text('Set Password',style: Theme.of(context).textTheme.titleLarge,),
                  Text('Minimum 8 character with letter and number combination.',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _setPasswordController,
                    decoration: InputDecoration(
                        hintText: 'New Password'
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Confirm Password'
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (){},
                    child: const Text('Confirm',style: TextStyle(color: Colors.white),),

                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: "Have an account?",style: TextStyle(color: Colors.black54) ),
                              TextSpan(
                                  text: " Sign In",
                                  style: TextStyle(color: Colors.green),
                                  recognizer: TapGestureRecognizer()..onTap = _onTapSignIn
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

  void _onTapSignIn(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Loginscreen()), (pre)=>false);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _setPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
