import 'package:flutter/material.dart';

void showSnakeBarMessage({required BuildContext context, required String message, bool isError = false}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),backgroundColor: isError? Colors.red : null,)
  );
}