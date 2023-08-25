import 'package:billapp/Page/login_page.dart';
import 'package:billapp/case_menu/case_menu_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const CaseHomePage(selectedTable: '',);
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
