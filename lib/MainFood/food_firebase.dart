import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  UserInformationState createState() => UserInformationState();
}

class UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('MainFood').get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // ignore: unused_local_variable
          final data = snapshot.data;
          return const SizedBox();
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          return const SizedBox();
        }
      },
    );
    /* return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('MainFood').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SizedBox();
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        return const Text("Loading");
      },
    );
  } */
  }
}
