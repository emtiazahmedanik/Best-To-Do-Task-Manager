class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String photo;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.photo
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        id: jsonData['_id'] ?? '',
        email: jsonData["email"] ?? '',
        firstName: jsonData["firstName"] ?? '',
        lastName: jsonData["lastName"] ?? '',
        mobile: jsonData["mobile"] ?? '',
        photo: jsonData["photo"] ?? ''
    );
  }

  Map<String, dynamic> toJson(){
    return{
      '_id':id,
      'email':email,
      'firstName':firstName,
      'lastName':lastName,
      'mobile':mobile,

    };
  }

  String get fullName{
    return '$firstName $lastName' ;
  }
}

// "data": {
// "_id": "680226ec32c08ed3a7c6ad58",
// "email": "email11@gmail.com",
// "firstName": "abwefc",
// "lastName": "afwbc",
// "mobile": "017777777777",
// "createdDate": "2025-02-22T06:57:26.194Z"
// },
