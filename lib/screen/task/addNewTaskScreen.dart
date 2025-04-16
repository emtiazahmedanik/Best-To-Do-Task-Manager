import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:flutter/material.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Screenbackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text("Add New Task",style: Theme.of(context).textTheme.titleLarge,),
                  SizedBox(height: 12,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Subject"),
                  ),
                  TextFormField(
                    maxLines: 6,
                    decoration: InputDecoration(
                        hintText: "Description",
                        contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 8)
                    ),
                  ),
                  SizedBox(height: 12,),
                  ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: const Icon(Icons.arrow_circle_right_outlined),

                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  void _onTapSubmitButton(){

  }
}
