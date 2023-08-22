import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordDialog> {
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (error) {
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              width: 2,
              color: Colors.white,
            )),
        scrollable: true,
        backgroundColor: Colors.green[900],
        title: const Text(
            'Enter your email and we will send you a password reset link'),
        content: Text(error.toString()),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                    )),
              ),
            ],
          )
        ],
      );
    }
  }

  // ignore: unused_field
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(
            width: 2,
            color: Colors.white,
          )),
      scrollable: true,
      backgroundColor: Colors.green[900],
      title: const Text(
          'Enter your email and we will send you a password reset link'),
      content: Form(
        child: TextFormField(
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
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            labelText: 'Email',
          ),
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty ||
                !value.contains('@') ||
                !value.trimRight().endsWith('.com')) {
              return 'Please enter a valid email adress';
            }
            return null;
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextButton(
                  onPressed: () {
                    passwordReset();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                  )),
            ),
          ],
        )
      ],
    );
  }
}
