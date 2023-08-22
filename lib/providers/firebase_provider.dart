 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseNotifier extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;

   
}

final firebaseProvider = ChangeNotifierProvider<FirebaseNotifier>((ref) {
  return FirebaseNotifier();
});
