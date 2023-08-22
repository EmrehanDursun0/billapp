 

enum AuthMode {
  login,
  signup,
}

class UserModel   {
  UserModel({
    required this.email,
     
    required this.password,
    required this.authMode,
    
  });

  String? email;
 
  AuthMode? authMode;
  String? password;
  
 
 
}