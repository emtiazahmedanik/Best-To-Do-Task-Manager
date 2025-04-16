import 'dart:io';

import 'package:besttodotask/widgets/tmAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(fromProfile: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.center,
                  child: SizedBox(
                    height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: _image!=null
                        ?FileImage(_image!,)
                        :AssetImage("assets/images/default.jpg "),
                      )
                  )
              ),
              Text("Update Profile",style: TextTheme.of(context).titleLarge,),
              SizedBox(height: 12),
              buildContainer(),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                //controller: _firstNameController,
                decoration: InputDecoration(
                    hintText: 'First Name'
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                //controller: _lastNameController,
                decoration: InputDecoration(
                    hintText: 'Last Name'
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                //controller: _mobileController,
                decoration: InputDecoration(
                    hintText: 'Mobile'
                ),
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                //controller: _passwordController,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),
              ElevatedButton(
                onPressed: _onTapSubmit,
                child: const Icon(Icons.arrow_circle_right_outlined),

              ),
              SizedBox(height: 20,)

            ],
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
                decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  children: [
                    Container(
                      width:80,
                      decoration:  BoxDecoration(
                        color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                      ),
                      alignment: Alignment.center,
                      child: const Text("Photo",style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(width: 8,),
                    Text("Select your photo")
                  ],
                ),
              ),
    );
  }

  Future<void> _onTapPhotoPicker() async{
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        _image = File(pickedImage.path);
      });
    }

  }
  void _onTapSubmit(){

  }
}
