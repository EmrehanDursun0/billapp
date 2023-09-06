import 'package:billapp/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> allCategories = [];

  Future<void> fetchAllCategories() async {
    final List<CategoryModel> categories = [];
    final snapshot = await FirebaseFirestore.instance
        .collection("categories")
        .orderBy("id")
        .get();
    if (snapshot.docs.isEmpty) {
      return;
    }
    for (final doc in snapshot.docs) {
      categories.add(CategoryModel.fromMap(doc.data()));
    }
    allCategories = categories;
    notifyListeners();
  }

  Future<CategoryModel?> fetchCategoryById(String id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where('id', isEqualTo: id)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    CategoryModel categoryModel = CategoryModel.fromMap(
        snapshot.docs.first.data() as Map<String, dynamic>);
    return categoryModel;
  }
}
