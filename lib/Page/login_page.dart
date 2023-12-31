import 'package:billapp/Page/choice_page.dart';
import 'package:billapp/authentication_screen/forgot_password_dialog.dart';
import 'package:billapp/models/user.dart';
import 'package:billapp/providers/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/table_provider.dart';

final firebase = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  void showResetPasswordDialog() {
    showDialog(context: context, builder: (context) => const ForgotPasswordDialog());
  }

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();

  bool isChecked = false;
  var _isLogin = true;
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = context.read<AuthenticationProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260900),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            Text(
              'Personel Giriş',
              style: GoogleFonts.judson(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu/splash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: const Color(0xFFE0A66B),
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          //autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: emailController,
                                cursorColor: Colors.white,
                                autocorrect: false,
                                autofocus: true,
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                    labelText: 'Email'),
                                onSaved: (newValue) {
                                  emailController.text = newValue!;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Bu alan boş bırakılamaz';
                                  } else if (!_isLogin && (!value.contains('@') || !value.trimRight().endsWith('.com'))) {
                                    return 'Geçerli bir Email adresi giriniz.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passwordController,
                                cursorColor: Colors.white,
                                autofocus: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                  labelText: 'Şifre',
                                ),
                                onSaved: (newValue) {
                                  passwordController.text = newValue!;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Bu alan boş bırakılamaz';
                                  } else if (value.length < 6) {
                                    return 'Şifre en az 6 karakter uzunluğunda olmalı';
                                  }
                                  return null;
                                },
                                obscureText: !isChecked,
                              ),
                              if (!_isLogin)
                                const SizedBox(
                                  height: 12,
                                ),
                              !_isLogin
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          controller: passwordController,
                                          cursorColor: Colors.white,
                                          autofocus: true,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              Icons.password,
                                              color: Colors.white,
                                            ),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(width: 2, color: Colors.white)),
                                            labelText: 'Şifreyi Onayla',
                                          ),
                                          validator: (value) {
                                            if (passwordController.text != value) {
                                              return 'Parolalar uyuşmuyor';
                                            }
                                            return null;
                                          },
                                          obscureText: !isChecked,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(
                                      height: 0,
                                    ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          fillColor: MaterialStateProperty.all(Colors.white),
                                          checkColor: Colors.green[900],
                                          value: isChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              isChecked = !isChecked;
                                            });
                                          }),
                                      const Text(
                                        'Şifreyi göster',
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  if (_isLogin)
                                    GestureDetector(
                                      onTap: () {
                                        showResetPasswordDialog();
                                      },
                                      child: const Text(
                                        'Şifrenizi mi unuttunuz ?',
                                      ),
                                    )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), fixedSize: const Size.fromHeight(55), backgroundColor: const Color(0xFF260900)),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          // Eğer form geçerliyse işlemi yap
                                          authenticationProvider.submitUserData(
                                            emailController.text,
                                            _isLogin ? AuthMode.login : AuthMode.signup,
                                            passwordController.text,
                                          );
                                          authenticationProvider.signWithEmailAndPassword();
                                          if (_isLogin) {
                                            final TableProvider tableProvider = context.read<TableProvider>();
                                            await tableProvider.fetchAllTables().then((_) {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChoicePage()));
                                            });
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Lütfen geçerli bilgileri girin.'),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        _isLogin ? 'Giriş Yap' : 'Hesap Oluştur',
                                        style: GoogleFonts.judson(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(
                                  _isLogin ? "Hesap oluşturunuz" : 'Hesabınız mevcut. Giriş yapınız',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
