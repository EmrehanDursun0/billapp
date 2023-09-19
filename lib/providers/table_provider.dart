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
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("tables")
        .orderBy("name")
        .get();
    if (snapshot.docs.isEmpty) {
      return;
    }
    for (final doc in snapshot.docs) {
      tables.add(TableModel.fromMap(doc.data() as Map<String, dynamic>));
    }

    //Masa sıralama
    tables.sort((a, b) {
      final tableNumberA = int.tryParse(a.name.substring(5)) ?? 0;
      final tableNumberB = int.tryParse(b.name.substring(5)) ?? 0;
      return tableNumberA - tableNumberB;
    });

    _allTables = tables;
    notifyListeners();
  }

  void selectTable(TableModel table) {
    _selectedTable = table;
    notifyListeners();
  }

  Future<void> changeTable(String newTable) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final mealRef = firestoreInstance.collection('tables');
    final documentReference = mealRef.doc();
    final id = documentReference.id;
    final mealData = {
      'name': newTable,
      'id': id,
    };

    try {
      await documentReference.set(mealData);

      final newTableModel = TableModel.fromMap({
        'name': newTable,
        'id': id,
      });

      _allTables.add(newTableModel);

      notifyListeners();
    } catch (e) {
  
      print("Masa eklenirken hata oluştu: $e");
    }
  }

  //Masa Silme
  Future<void> removeTable(TableModel table) async {
    final firestoreInstance = FirebaseFirestore.instance;
    final mealRef = firestoreInstance.collection('tables');

    try {
      await mealRef.doc(table.id).delete();

      _allTables.removeWhere((existingTable) => existingTable.id == table.id);

      if (_selectedTable != null && _selectedTable!.id == table.id) {
        _selectedTable = null;
      }

      notifyListeners();
    } catch (e) {
      
      print("Masa silinirken hata oluştu: $e");
    }
  }
}
