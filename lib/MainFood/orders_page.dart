import 'package:billapp/MainFood/firebase/orders_firebase.dart';
import 'package:billapp/models/order.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    super.key,
    required this.title,
    required this.id,
  });
  final String title;
  final String id;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = context.read<OrderProvider>();
    final TableProvider tableProvider = context.watch<TableProvider>();
    final OrderModel selectedtable = tableProvider.selectedTable;
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
                '',
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
      body: const OrderFirebase(
        orderId: '',
        collectionName: '',
        selectedTable: '',
      ),
    );
  }
}
