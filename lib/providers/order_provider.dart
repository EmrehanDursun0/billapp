import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/models/order.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> updateOrderedAmount(String id, int newAmount) async {
    final firestore = FirebaseFirestore.instance;
    try {
      if (newAmount < 0) {
        final orderProductRef = firestore.collection('orderProducts').doc(id);
        await orderProductRef.delete();
      } else {
        final orderProductRef = firestore.collection('orderProducts').doc(id);
        await orderProductRef.update({
          'orderedAmount': newAmount,
        });
      }
    } catch (error) {
      print('Sipariş ürünü güncelleme hatası: $error');
    }
  }

  double calculateTotalPrice(OrderModel orderModel) {
    double total = 0.0;
    for (var orderProduct in orderModel.orderProducts) {
      total += (orderProduct.product!.price! * orderProduct.orderedAmount);
    }
    return total;
  }

  Future<void> saveOrder(OrderModel order) async {
    final firestore = FirebaseFirestore.instance;
    try {
      double totalPrice = calculateTotalPrice(order); // Toplam tutarı hesaplama

      // Eski sipariş ürünlerini  'orderProducts' içinden siler
      await firestore.collection('orderProducts').where('orderId', isEqualTo: order.id).get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });

      // Yeni siparişi kaydedin
      await firestore.collection('orders').doc(order.id).set({
        'id': order.id,
        'tableId': order.tableId,
        'totalPrice': totalPrice,
        'timeStamp': FieldValue.serverTimestamp(),
      });

      // Yeni sipariş ürünlerini ekleyin
      for (var orderProduct in order.orderProducts) {
        final newOrderProductRef = firestore.collection('orderProducts').doc();
        await newOrderProductRef.set({
          'id': orderProduct.id,
          'orderId': order.id,
          'productId': orderProduct.product!.id,
          'orderedAmount': orderProduct.orderedAmount,
        });
      }
    } catch (error) {
      print('Siparişi kaydetme hatası: $error');
    }
  }

  Future<void> ordersSelection(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFE0A66B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, setState) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DynamicMenuPage(),
                  ),
                );
              });

              return Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0A66B).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Şiparişiniz Alınmıştır",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.judson(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Image.asset(
                          'assets/check.png',
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
