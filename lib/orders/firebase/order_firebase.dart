import 'package:billapp/models/order.dart';
import 'package:billapp/models/order_product.dart';
import 'package:billapp/models/table.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderFirebase extends StatefulWidget {
  final String orderId;

  const OrderFirebase({Key? key, required this.orderId, required String collectionName, required String selectedTable}) : super(key: key);

  @override
  State<OrderFirebase> createState() => _OrderFirebaseState();
}

class _OrderFirebaseState extends State<OrderFirebase> {
  double totalPrice = 0.0;
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = context.watch<OrderProvider>();
    final TableProvider tableProvider = context.watch<TableProvider>();
    final TableModel selectedtable = tableProvider.selectedTable;
    return FutureBuilder(
      future: orderProvider.fetchOrderByTableId(context, selectedtable.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          final OrderModel orderModel = snapshot.data;
          totalPrice = orderProvider.calculateTotalPrice(orderModel);

          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/menu/splash.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.9),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderModel.orderProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final OrderProductModel orderProduct = orderModel.orderProducts[index];

                          return ListTile(
                            title: FittedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: Text(
                                      orderProduct.product!.name.toString(),
                                      style: GoogleFonts.judson(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 60,
                                    height: 50,
                                    child: Text(
                                      "${orderProduct.product!.price} TL",
                                      style: GoogleFonts.judson(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 70,
                                    height: 50,
                                    child: Text(
                                      orderProduct.product!.liter,
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
                            trailing: SizedBox(
                              width: 50,
                              height: 50,
                              child: Text(
                                '${orderProduct.orderedAmount.toString()} adet',
                                style: GoogleFonts.judson(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            'Toplam Ücret:',
                            style: GoogleFonts.judson(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 150),
                          Text(
                            '${totalPrice.toStringAsFixed(2)} TL',
                            style: GoogleFonts.judson(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (orderModel.isConfirmed) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Uyarı"),
                                content: const Text("Mevcut bir siparişiniz zaten var!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Tamam"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          await orderProvider.ordersSelection(context);
                          await orderProvider.saveOrder(orderModel);
                          orderModel.isConfirmed = true;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xFFE0A66B),
                        fixedSize: const Size(230, 60),
                      ),
                      child: Text(
                        'Siparişi Onayla',
                        style: GoogleFonts.judson(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: Text("Sipariş  yok"));
      },
    );
  }
}
