import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodFirebase extends StatelessWidget {
  const FoodFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('MainFood').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final name = data['Name'] ?? '';
              final price = data['Price'].toString();

              return ListTile(
                title: Text(name),
                subtitle: Text(price),
                
              );
            }).toList(),
          );
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const FoodFirebase());
}
