import 'package:billapp/menu_upgrade/menu_function.dart';
import 'package:billapp/models/products.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class DynamicCustomListTile extends StatefulWidget {
  const DynamicCustomListTile({super.key, required this.activeProduct});
  final ProductModel activeProduct;

  @override
  State<DynamicCustomListTile> createState() => _DynamicCustomListTileState();
}

class _DynamicCustomListTileState extends State<DynamicCustomListTile> {
  Map<String, int> productQuantities = {};

  String orderProductId = const Uuid().v4();
  int orderedAmount = 0;
  @override
  Widget build(BuildContext context) {
    final ProductModel product = widget.activeProduct;

    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    if (billAppProvider.menuMode == MenuMode.customer) {
      return Column(
        children: [
          ListTile(
            title: Column(
              children: [
                const SizedBox(height: 20),
                FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: Text(
                          product.name,
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Text(
                          "${product.price} TL",
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 80,
                        height: 40,
                        child: Text(
                          product.liter,
                          style: GoogleFonts.judson(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () {
                    if (orderedAmount > 0) {
                      setState(() {
                        orderedAmount--;
                        updateProductQuantity(orderProductId, orderedAmount, context);
                      });
                    }
                  },
                ),
                Text(orderedAmount.toString(),
                    style: GoogleFonts.judson(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      orderedAmount++;
                      updateProductQuantity(orderProductId, orderedAmount, context);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return ListTile(
          title: FittedBox(
            child: Row(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Text(
                    product.name,
                    style: GoogleFonts.judson(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 50,
                  height: 30,
                  child: Text(
                    "${product.price} TL",
                    style: GoogleFonts.judson(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 80,
                  height: 40,
                  child: Text(
                    product.liter,
                    style: GoogleFonts.judson(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              dynamicUpdatePage(context, product.id, product.name, product.price.toString(), product.liter, product.categoryId, Buttonmode.update);
            },
            icon: const Icon(
              color: Colors.white,
              IconData(
                0xe7f7,
                fontFamily: 'MaterialIcons',
              ),
            ),
          ));
    }
  }

  Future<void> updateProductQuantity(
    String productId,
    int orderedAmount,
    BuildContext context,
  ) async {
    final TableModel selectedTable = context.read<TableProvider>().selectedTable;
    final firestoreInstance = FirebaseFirestore.instance;
    final orderProductCollection = firestoreInstance.collection('orderProducts');

    final orderCollection = firestoreInstance.collection('orders');
    final documentReference = orderCollection.doc();

    final String orderId = documentReference.id;

    final ProductModel product = widget.activeProduct;

    if (orderedAmount <= 0) {
      // Yeni miktar 0 veya daha azsa, siparişi sil
      orderProductCollection.doc(orderProductId).delete().then((_) {
        setState(() {
          productQuantities.remove(orderProductId);
          debugPrint('Sipariş silindi.');
        });
      }).catchError((error) {
        debugPrint('Sipariş silinirken hata oluştu: $error');
      });
    } else {
      // Yeni miktar 0'dan büyükse, miktarı güncelle veya yeni sipariş ekle
      setState(() {
        productQuantities[orderProductId] = orderedAmount;
      });

      orderCollection.doc(orderId).get().then((docSnapshot) {
        if (docSnapshot.exists) {
          // Sipariş zaten varsa miktarı güncelle
          final orderData = {
            'productId': product.id,
            'orderedAmount': orderedAmount,
            'timeStamp': FieldValue.serverTimestamp(),
          };
          orderProductCollection.doc(orderProductId).set(orderData, SetOptions(merge: true));
          debugPrint('Sipariş miktarı güncellendi.');
        } else {
          // Sipariş veritabanında yoksa yeni sipariş ekle

          final orderData = {
            'id': orderId,
            'tableId': selectedTable.id,
            'totalPrice': 0,
            'timeStamp': FieldValue.serverTimestamp(),
          };
          final orderProductData = {
            'id': orderProductId,
            'orderId': orderId,
            'productId': product.id,
            'orderedAmount': orderedAmount,
          };

          orderCollection.doc(orderId).set(orderData);
          orderProductCollection.doc(orderProductId).set(orderProductData);

          debugPrint('Yeni sipariş başarıyla eklendi.');
        }
      }).catchError((error) {
        debugPrint('Veritabanı hatası: $error');
      });
    }
  }
}
