import 'package:billapp/models/order_product.dart';
import 'package:billapp/models/products.dart';
import 'package:billapp/providers/categoires_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _allProducts = [];

  get allProducts => _allProducts;

  Future<void> fetchAllProducts(BuildContext context) async {
    final List<ProductModel> products = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("products").get();
    for (final doc in snapshot.docs) {
      final product = ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      if (context.mounted) {
        product.category = await context.read<CategoryProvider>().fetchCategoryById(product.categoryId.toString());
      }
      products.add(product);
    }
    _allProducts = products;
    notifyListeners();
  }

  Future<List<OrderProductModel>> fetchProductsByOrderId(String orderId) async {
    List<OrderProductModel> orderProducts = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("orderProducts").where("orderId", isEqualTo: orderId).get();
    if (snapshot.docs.isEmpty) {
      return [];
    }
    for (final doc in snapshot.docs) {
      final OrderProductModel orderProductModel = OrderProductModel.fromMap(doc.data() as Map<String, dynamic>);
      orderProductModel.product = _allProducts.firstWhere((x) => x.id == orderProductModel.productId);
      orderProducts.add(orderProductModel);
    }
    return orderProducts;
  }
}