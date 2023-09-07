import 'package:billapp/models/order.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  //eski method degistirilecek
  // Future<List<String>> orderTableList() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("OrderProducts").get();
  //   List<String> tableList = snapshot.docs.map((doc) => doc['name'].toString()).toList();
  //   return tableList;
  // }

  Future<List<OrderModel>> fetchAllOrders(BuildContext context) async {
    List<OrderModel> orders = [];
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("orders").where("timeStamp", isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay)).get();
    if (snapshot.docs.isEmpty) {
      return [];
    }
    for (final doc in snapshot.docs) {
      final OrderModel order = OrderModel.fromMap(doc.data() as Map<String, dynamic>);
      late TableModel? tableModel;
      if (context.mounted) {
        tableModel = context.read<TableProvider>().allTables.firstWhere((x) => x.id == order.tableId) as TableModel;
      }
      order.table = tableModel;
      if (context.mounted) {
        order.orderProducts = await context.read<ProductProvider>().fetchProductsByOrderId(order.id);
      }
      orders.add(order);
    }
    return orders;
  }

  Future<OrderModel?> fetchOrderByTableId(BuildContext context, String id) async {
    List<OrderModel> orders = [];
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("orders").where("tableId", isEqualTo: id).where("timeStamp", isGreaterThan: Timestamp.fromDate(startOfDay)).get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    for (final doc in snapshot.docs) {
      final OrderModel order = OrderModel.fromMap(doc.data() as Map<String, dynamic>);
      orders.add(order);
    }
    orders.sort((a, b) => b.dateTime!.compareTo(a.dateTime!));
    OrderModel latestOrder = orders.first;

    late TableModel? tableModel;

    if (context.mounted) {
      tableModel = context.read<TableProvider>().allTables.firstWhere((x) => x.id == latestOrder.tableId) as TableModel;
    }
    latestOrder.table = tableModel;
    if (context.mounted) {
      latestOrder.orderProducts = await context.read<ProductProvider>().fetchProductsByOrderId(latestOrder.id);
    }

    return latestOrder;
  }
}
