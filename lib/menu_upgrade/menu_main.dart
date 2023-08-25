import 'package:billapp/MainFood/firebase/main_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({super.key, required this.selectedTable});
  final String selectedTable;
  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
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
                'Ana Yemekler Güncelle',
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
      body: const MainFirebase(
        collectionName: 'MainFood',
      ),
    );
  }
}
