import 'package:besttodotask/data/model/userModel.dart';

class LoginModel {
  final String status;
  final String token;
  final UserModel userModel;

  LoginModel({
    required this.status,
    required this.token,
    required this.userModel,
  });

  factory LoginModel.fromJson(Map<String, dynamic> jsonData) {
    return LoginModel(
        status: jsonData['status'] ?? '',
        token: jsonData['token'] ?? '',
        userModel: UserModel.fromJson(jsonData['data'] ?? {})
    );
  }

}
