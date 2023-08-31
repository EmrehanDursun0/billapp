import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Sipariş belgesini temsil eden sınıf
class OrderDocument {
  final String productId;
  final String name;
  final String price;
  final int quantity;
  final String additionalInfo;
  final String timestamp;

  OrderDocument({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.additionalInfo,
    required this.timestamp,
  });
}

class OrderProductsFirebase extends StatefulWidget {
  const OrderProductsFirebase({Key? key}) : super(key: key);

  @override
  OrderProductsFirebaseState createState() => OrderProductsFirebaseState();
}

class OrderProductsFirebaseState extends State<OrderProductsFirebase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu/splash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: SizedBox(
          width: 150,
          height: 30,
          child: Text(
            "order.name,",
            style: GoogleFonts.judson(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Future<List<String>> orderTableList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("OrderProducts").get();
    List<String> tableList =
        snapshot.docs.map((doc) => doc['name'].toString()).toList();
    return tableList;
  }
}
