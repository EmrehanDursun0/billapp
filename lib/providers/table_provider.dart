import 'package:billapp/models/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TableProvider extends ChangeNotifier {
  List<TableModel> _allTables = [];
  TableModel? _selectedTable;

  get allTables => _allTables;
  get selectedTable => _selectedTable;

  Future<void> fetchAllTables() async {
    final List<TableModel> tables = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("tables").orderBy("name").get();
    if (snapshot.docs.isEmpty) {
      return;
    }
    for (final doc in snapshot.docs) {
      tables.add(TableModel.fromMap(doc.data() as Map<String, dynamic>));
    }
    _allTables = tables;
    notifyListeners();
  }

  void selectTable(TableModel table) {
    _selectedTable = table;
    notifyListeners();
  }
}
