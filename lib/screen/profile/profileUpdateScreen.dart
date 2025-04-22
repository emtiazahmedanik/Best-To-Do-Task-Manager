import 'dart:convert';
import 'dart:io';

import 'package:besttodotask/data/model/userModel.dart';
import 'package:besttodotask/data/service/networkClient.dart';
import 'package:besttodotask/data/utils/urls.dart';
import 'package:besttodotask/screen/controller/authController.dart';
import 'package:besttodotask/widgets/snackBarMessage.dart';
import 'package:besttodotask/widgets/tmAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  late final String _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel userModel = AuthController.userModel!;
    _firstNameController.text = userModel.firstName;
    _lastNameController.text = userModel.lastName;
    _mobileController.text = userModel.mobile;
    _email = userModel.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfile: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundImage:
                          _image != null
                              ? FileImage(File(_image!.path))
                              : AssetImage("assets/images/default.jpg"),
                    ),
                  ),
                ),
                Text("Update Profile", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 12),
                buildContainer(),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _firstNameController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your first name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  controller: _lastNameController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return "Enter your last name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  controller: _mobileController,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    RegExp regEx = RegExp(r"^(?:\+88|88)?(01[3-9]\d{8})$");
                    String phone = value?.trim() ?? "";
                    if (regEx.hasMatch(phone) == false) {
                      return "Enter valid phone number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                Visibility(
                  visible: _isLoading == false,
                  replacement: Center(
                    child: SquareProgressIndicator(color: Colors.green),
                  ),
                  child: ElevatedButton(
                    onPressed: _onTapSubmit,
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer() {
    return GestureDetector(
      onTap: _onTapPhotoPicker,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              child: const Text("Photo", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                  _image?.name ?? "Select your photo",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onTapPhotoPicker() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _onTapSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      //ToDo update profile

      Map<String, dynamic> requestBody = {
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "mobile": _mobileController.text.trim(),
      };
      if (_image != null) {
        List<int> imageBytes = await _image!.readAsBytes();
        String encodedImage = base64Encode(imageBytes);
        requestBody["photo"] = encodedImage;
      }
      if (_passwordController.text.isNotEmpty) {
        requestBody["password"] = _passwordController.text;
      }

      NetworkResponse response = await NetworkClient.postRequest(
        url: Urls.updateProfile,
        body: requestBody,
      );

      setState(() {
        _isLoading = false;
      });
      if (response.isSuccess) {
        requestBody["email"] = _email;
        UserModel user = UserModel.fromJson(requestBody);
        await AuthController.updateProfileData(user);
        showSnakeBarMessage(
          context: context,
          message: "Profile updated successfully",
        );
        _clearController();
      } else {
        showSnakeBarMessage(context: context, message: "Something went wrong");
      }
    }
  }

  void _clearController() {
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _mobileController.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
