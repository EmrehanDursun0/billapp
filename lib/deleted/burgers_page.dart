import 'package:billapp/MainFood/firebase/main_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BurgersPage extends StatefulWidget {
  const BurgersPage({super.key, required this.selectedTable});
  final String selectedTable;
  @override
  State<BurgersPage> createState() => _BurgersPageState();
}

class _BurgersPageState extends State<BurgersPage> {
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
                'Ana Yemekler',
                style: GoogleFonts.judson(
                  fontSize: 20,
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
      body:   MainFirebase(
        collectionName: 'MainFood',selectedTable: widget.selectedTable,
      ),
    );
  }
}