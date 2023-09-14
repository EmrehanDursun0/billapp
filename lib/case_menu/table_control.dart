import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> tablecontrol(BuildContext context, selectedtable) async {
  final TableProvider tableProvider = context.read<TableProvider>();
  final List<TableModel> allTables = tableProvider.allTables;

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
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
                  "Masa Düzenle",
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
            ElevatedButton(
              onPressed: () {
                addTable(context, allTables);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFF260900),
                fixedSize: const Size(140, 40),
              ),
              child: Text(
                'Masa Ekle',
                style: GoogleFonts.judson(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> addTable(BuildContext context, List<TableModel> allTables) async {
  int highestTableNumber = 0;
  for (final table in allTables) {
    final tableNumber =
        int.tryParse(table.name.replaceAll(RegExp(r'[^0-9]'), ''));
    if (tableNumber != null && tableNumber > highestTableNumber) {
      highestTableNumber = tableNumber;
    }
  }

  final newTableName = 'Masa ${highestTableNumber + 1}';

  final newTable = TableModel(name: newTableName);
  ddTable(newTable);

  // Yeni masa seçme ve sayfaya yönlendirme
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const DynamicMenuPage(),
    ),
  );
}

Future<void> ddTable(newTable) async {
  final firestoreInstance = FirebaseFirestore.instance;
  final mealRef = firestoreInstance.collection('tables');
  final documentReference = mealRef.doc();
  final id = documentReference.id;
  final mealData = {
    'name': newTable,
    'id': id,
  };
  await documentReference.set(mealData);
}