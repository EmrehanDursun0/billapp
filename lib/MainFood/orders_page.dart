import 'package:billapp/firebase/order_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.selectedTable});
  final String selectedTable;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
                'Siparişlerim',
                style: GoogleFonts.judson(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 100),
              Text(
                widget.selectedTable,
                style: GoogleFonts.judson(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: OrderFirebase(
        collectionName: 'Orders',
        selectedTable: widget.selectedTable,
        orderId: '',
      ),
    );
  }
}
