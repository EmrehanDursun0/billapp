import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future<void> tablecontrol(BuildContext context, selectedtable) async {
  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final TableProvider tableProvider = context.watch<TableProvider>();
      final allTables = tableProvider.allTables; // Tüm tabloları al

      return AlertDialog(
        insetPadding: const EdgeInsets.all(20),
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: const Color(0xFF260900),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Güncelleme Sayfası',
                    style: GoogleFonts.judson(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: allTables.length,
                itemBuilder: (BuildContext context, int index) {
                  String tableName = allTables[index];
                  return InkWell(
                    onTap: () {
                      selectedtable = tableName;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF260900),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tableName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
