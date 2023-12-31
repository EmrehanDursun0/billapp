// ignore_for_file: unnecessary_null_comparison

import 'package:billapp/models/table.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:billapp/providers/table_provider.dart';
// import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicCategoriesAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const DynamicCategoriesAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    final TableProvider tableProvider = context.watch<TableProvider>();
    final TableModel? selectedTable = tableProvider.selectedTable;
    if (billAppProvider.menuMode == MenuMode.customer) {
      return AppBar(
        backgroundColor: const Color(0xFF260900),
        leading: GestureDetector(),
        title: Text(
          'Menü',
          style: GoogleFonts.judson(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: Text(selectedTable!.name,
                  style: GoogleFonts.judson(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          )
        ],
      );
    } else {
      return AppBar(
        backgroundColor: const Color(0xFF260900),
        title: Text(
          'Menü Güncelle',
          style: GoogleFonts.judson(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
