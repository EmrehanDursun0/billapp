// ignore_for_file: avoid_print

import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/models/order.dart';
import 'package:billapp/models/order_product.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class OrderProvider extends ChangeNotifier {
  String? activeOrder;
  void changeActiveOrder(String? activeOrder) {
    this.activeOrder = activeOrder;
    notifyListeners();
  }

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

  Future<List<OrderModel>> orderfinish(BuildContext context) async {
    List<OrderModel> orders = [];
    DateTime now = DateTime.now();
    DateTime startOfDay = DateTime(now.year, now.month, now.day);
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("ordersFinished").where("timeStamp", isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay)).get();
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
      if (newAmount <= 0) {
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
        final newOrderProductRef = firestore.collection('orderProducts').doc(orderProduct.id);
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

  Future<void> ordersFinished(OrderModel selectedOrder) async {
    final firestore = FirebaseFirestore.instance;
    try {
      // Ödeme alındığında taşınacak verileri al
      final orderData = {
        'tableId': selectedOrder.tableId,
        'totalPrice': selectedOrder.totalPrice,
        'timeStamp': FieldValue.serverTimestamp(),
        'id': selectedOrder.id,

        // Diğer gerekli verileri ekleyin
      };

      final orderProducts = selectedOrder.orderProducts.map((orderProduct) {
        return {
          'orderId': selectedOrder.id,
          'productId': orderProduct.product!.id,
          'orderedAmount': orderProduct.orderedAmount,
          // Diğer gerekli verileri ekleyin
        };
      }).toList();

      // 'ordersfinished' koleksiyonuna kayıt yaparken belirli bir ID ile kayıt yapma

      await firestore.collection('ordersFinished').doc(selectedOrder.id).set(orderData);

      // 'ordersFinished_orderProducts' koleksiyonuna kayıt yaparken belirli bir ID ile kayıt yapma
      for (var orderProductData in orderProducts) {
        await firestore.collection('ordersFinished_orderProducts').add(orderProductData);
      }

      // 'orders' koleksiyonundan verileri sil
      await firestore.collection('orders').doc(selectedOrder.id).delete();

      // 'orderProducts' koleksiyonundaki ilgili verileri sil
      await firestore.collection('orderProducts').where('orderId', isEqualTo: selectedOrder.id).get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
      changeActiveOrder(null);
    } catch (error) {
      print('Veri taşıma ve silme hatası: $error');
    }
  }

  Future<void> saveOrders(BuildContext context, List<OrderProductModel> selectedProducts) async {
    final TableModel selectedTable = context.read<TableProvider>().selectedTable;
    final firestoreInstance = FirebaseFirestore.instance;
    final orderProductCollection = firestoreInstance.collection('orderProducts');
    final documentReference = orderProductCollection.doc();
    String orderId = activeOrder ?? documentReference.id;

    try {
      for (final orderProductModel in selectedProducts) {
        String orderProductId = const Uuid().v4();
        await orderProductCollection.add({
          'id': orderProductId,
          'orderId': orderId,
          'productId': orderProductModel.productId,
          'orderedAmount': orderProductModel.orderedAmount,
        });
      }

      await firestoreInstance.collection('orders').doc(orderId).set({
        'id': orderId,
        'tableId': selectedTable.id,
        'totalPrice': 0,
        'timeStamp': FieldValue.serverTimestamp(),
      });
      changeActiveOrder(orderId);
    } catch (error) {
      print('Siparişi kaydetme hatası: $error');
    }
  }
}
