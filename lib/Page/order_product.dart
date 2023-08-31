import 'package:billapp/MainFood/firebase/orderProducts_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderProductsPage extends StatefulWidget {
  const OrderProductsPage({
    super.key,
  });

  @override
  State<OrderProductsPage> createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> {
  @override
  Widget build(BuildContext context) {
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
        title: FittedBox(
          child: Row(
            children: [
              Text(
                'Masalar',
                style: GoogleFonts.judson(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: OrderProductsFirebase(),
    );
  }
}
