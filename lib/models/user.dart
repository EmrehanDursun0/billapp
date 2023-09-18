import 'package:billapp/models/model_base.dart';

enum AuthMode {
  login,
  signup,
}

// class UserModel {UserModel({required this.email,required this.password,required this.authMode,});

//   String? email;

//
//   String? password;

// }

class UserModel extends ModelBase {
  late String email;
  late String password;
  AuthMode? authMode;
  UserModel({required String email, required String password});

  UserModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    email = data['email'];
    password = data['password'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
