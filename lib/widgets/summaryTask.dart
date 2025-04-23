import 'package:flutter/material.dart';

class SummaryTask extends StatelessWidget {
  const SummaryTask({
    super.key,
    required this.count,
    required this.title
  });

  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Card(
        shape: RoundedRectangleBorder(),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          child: Column(
            children: [
              Text("$count",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text(title, style: TextStyle(color: Colors.black),)
            ],
          ),
        ),
      ),
    );
  }
}
