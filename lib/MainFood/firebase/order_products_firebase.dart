import 'package:billapp/models/order.dart';
import 'package:billapp/models/order_product.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderProductsFirebase extends StatefulWidget {
  const OrderProductsFirebase({Key? key}) : super(key: key);

  @override
  OrderProductsFirebaseState createState() => OrderProductsFirebaseState();
}

class OrderProductsFirebaseState extends State<OrderProductsFirebase> {
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = context.read<OrderProvider>();
    return FutureBuilder(
      future: orderProvider.fetchAllOrders(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final List<OrderModel> orders = snapshot.data;

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
                    Text(
                      "Sipariş Bekleyenler",
                      style: GoogleFonts.judson(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          final order = orders[index];

                          return ListTile(
                            title: FittedBox(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        order.table!.name,
                                        style: GoogleFonts.judson(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${order.totalPrice.toString()} TL",
                                        style: GoogleFonts.judson(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Text(
                                        "${order.hour}",
                                        style: GoogleFonts.judson(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // seçilen masanın siparişlerini görüntülemek için
                            onTap: () {
                              showTableOrders(context, order);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(child: Text("Sipariş yok"));
      },
    );
  }
}

Future<void> showTableOrders(BuildContext context, OrderModel selectedOrder) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Container(
          padding: const EdgeInsets.all(12),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color(0xFF260900),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              "${selectedOrder.table!.name} Siparişleri",
              style: GoogleFonts.judson(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        content: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: const Color(0xFFE0A66B).withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedOrder.orderProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final OrderProductModel orderProduct = selectedOrder.orderProducts[index];
                      return ListTile(
                        title: Text(
                          "Ürün Adı: ${orderProduct.product!.name}",
                          style: GoogleFonts.judson(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              "Ücreti: ${orderProduct.product!.price!}",
                              style: GoogleFonts.judson(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Adet: ${orderProduct.orderedAmount}",
                              style: GoogleFonts.judson(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Text("data"),
                  ElevatedButton(
                    onPressed: () async {
                      //   final OrderProvider orderProvider = context.read<OrderProvider>();
                      // await orderProvider.orderTableList();
                      // ordersSelection(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFF260900),
                      fixedSize: const Size(230, 60),
                    ),
                    child: Text(
                      'Ödeme Al ',
                      style: GoogleFonts.judson(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
