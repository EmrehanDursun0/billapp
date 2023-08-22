import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("Giriş başarılı.");
    } catch (e) {
      print("Giriş sırasında bir hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Personel Girişi',
                    style: GoogleFonts.judson(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı Adı',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0A66B),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.7,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: const Color(0xFFE0A66B),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.length > 6) {
                      login();
                    } else {
                      print("E-posta ve şifre gereklidir.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.08),
                    ),
                    backgroundColor: const Color(0xFF260900),
                    fixedSize: const Size(280, 50),
                  ),
                  child: Text('Giriş Yap',
                      style: GoogleFonts.judson(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.08),
                    ),
                    backgroundColor: const Color(0xFF260900),
                    fixedSize: const Size(280, 50),
                  ),
                  child: Text('Personel Kayıt',
                      style: GoogleFonts.judson(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
