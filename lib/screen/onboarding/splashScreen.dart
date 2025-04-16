import 'package:besttodotask/screen/onboarding/loginScreen.dart';
import 'package:besttodotask/utility/utility.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
  Future<void> _moveToNextScreen() async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenbackground(
          child: Center(
              child: SvgPicture.asset(AssetPath.logoSvg,width: 120,)
          )

      )
    );
  }
}
