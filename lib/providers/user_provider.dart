import 'package:billapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> allUsers = [];

  Future<void> fetchAllUsers() async {
    final List<UserModel> users = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("users").get();
    if (snapshot.docs.isEmpty) {
      return;
    }
    for (final doc in snapshot.docs) {
      users.add(UserModel.fromMap(doc.data() as Map<String, dynamic>));
    }
  }
}
