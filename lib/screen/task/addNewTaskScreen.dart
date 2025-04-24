import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/authController.dart';
import 'package:besttodotask/widgets/screenBackground.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final _titleEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      body: Screenbackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _titleEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: "Subject"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a title";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionEditingController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Description",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter a description";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  Visibility(
                    visible: _isLoading == false,
                    replacement: const Center(child: SquareProgressIndicator(color: Colors.green,)),
                    child: ElevatedButton(
                      onPressed: _onTapSubmitButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      addNewTask();

    }
  }


  Future<void> addNewTask() async {
    setState(() {
      _isLoading = true;
    });
    Map<String, dynamic> requestBody = {
      "title": _titleEditingController.text.trim(),
      "description": _descriptionEditingController.text.trim(),
      "status": "New",
    };
    final NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.createTask,
      body: requestBody,
    );
    setState(() {
      _isLoading = false;
    });
    if(response.isSuccess){
      showSnakeBarMessage(context: context, message: "New task added");
      _clearTextField();
      Navigator.pop(context,"updated");
    }else{
      showSnakeBarMessage(context: context, message: response.errorMessage,isError: true);
    }
  }

  void _clearTextField(){
    _titleEditingController.clear();
    _descriptionEditingController.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }
}
