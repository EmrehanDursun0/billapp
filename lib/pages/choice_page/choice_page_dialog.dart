import 'package:billapp/menu_update/dynamic_menu_page.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChoicePageDialog extends StatelessWidget {
  const ChoicePageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TableProvider tableProvider = context.watch<TableProvider>();
    final List<TableModel> allTables = tableProvider.allTables;
    return AlertDialog(
      backgroundColor: const Color(0xFFE0A66B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: const Color(0xFF260900),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Masa Seçimi",
                style: GoogleFonts.judson(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            height: 340,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: allTables.length,
              itemBuilder: (BuildContext context, int index) {
                final table = allTables[index];
                return ListTile(
                  onTap: () {
                    tableProvider.selectTable(table);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DynamicMenuPage(),
                      ),
                    );
                  },
                  title: Text(
                    table.name,
                    style: GoogleFonts.judson(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
