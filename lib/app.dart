
import 'package:besttodotask/screen/onboarding/splashScreen.dart';
import 'package:flutter/material.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "poppins",
        colorSchemeSeed: Colors.green.shade500,
        inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey
            ),
            border: _getOutlineBorder(),
            enabledBorder: _getOutlineBorder(),
            errorBorder: _getOutlineBorder()
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              )
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),

        )
      ),
      home: Splashscreen(),
    );
  }

  OutlineInputBorder _getOutlineBorder(){
    return const OutlineInputBorder(
        borderSide: BorderSide.none
    );
  }
}
