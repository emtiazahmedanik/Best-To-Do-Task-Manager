import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/screenBackground.dart';

class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class _RegistrationscreenState extends State<Registrationscreen> {

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    SizedBox(height: 30,),
                    Text('Join With Us',style: Theme.of(context).textTheme.titleLarge,),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: _firstNameController,
                      decoration: InputDecoration(
                          hintText: 'First Name'
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: _lastNameController,
                      decoration: InputDecoration(
                          hintText: 'Last Name'
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _mobileController,
                      decoration: InputDecoration(
                          hintText: 'Mobile'
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: 'Password'
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onTapSubmit,
                      child: const Icon(Icons.arrow_circle_right_outlined),

                    ),
                    Center(
                      child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: "Already have an account ?",style: TextStyle(color: Colors.black54) ),
                                TextSpan(
                                    text: " Sign In",
                                    style: TextStyle(color: Colors.green),
                                    recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton
                                )
                              ]
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }

  void _onTapSignInButton(){
    Navigator.pop(context);
  }

  void _onTapSubmit(){

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
