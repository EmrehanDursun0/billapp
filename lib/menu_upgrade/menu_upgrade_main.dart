import 'package:billapp/menu_upgrade/menu_upgrade_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuUpgradePage extends StatefulWidget {
  final String title;
  final String selectedCategory;

  const MenuUpgradePage({
    Key? key,
    required this.title,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  State<MenuUpgradePage> createState() => _MenuUpgradePageState();
}

class _MenuUpgradePageState extends State<MenuUpgradePage> {
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
                widget.title,
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 100),
            ],
          ),
        ),
      ),
      body: MenuUpgradeFirebase(
        collectionName: widget.selectedCategory,
      ),
    );
  }
}
