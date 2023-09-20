import 'package:billapp/models/order.dart';
import 'package:billapp/models/order_product.dart';
import 'package:billapp/orders/orders_product.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderProductsFirebase extends StatefulWidget {
  const OrderProductsFirebase({Key? key, required bool isWaiting}) : super(key: key);

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
          return const Center(child: CircularProgressIndicator());
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
                  builder: (context) => const OrderProductsPage(),
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
                        "Peşin Ödeme Yapılmıştır",
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

Future<void> showTableOrders(BuildContext context, OrderModel selectedOrder) async {
  double totalPrice = 0;
  for (var orderProduct in selectedOrder.orderProducts) {
    totalPrice += orderProduct.product!.price! * orderProduct.orderedAmount;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFFE0A66B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: Container(
          padding: const EdgeInsets.all(5),
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
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            color: const Color(0xFFE0A66B).withOpacity(0.6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectedOrder.orderProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final OrderProductModel orderProduct = selectedOrder.orderProducts[index];
                      return ListTile(
                        title: Text(
                          "Ürün Adı: ${orderProduct.product!.name}",
                          style: GoogleFonts.judson(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              "Ücreti: ${orderProduct.product!.price!}",
                              style: GoogleFonts.judson(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Adet: ${orderProduct.orderedAmount}",
                              style: GoogleFonts.judson(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Ücreti: ${orderProduct.orderedAmount * orderProduct.product!.price!}",
                              style: GoogleFonts.judson(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                color: const Color(0xFF260900),
                child: Text(
                  "   Toplam Ücret: $totalPrice TL   ",
                  style: GoogleFonts.judson(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                ordersSelection(context);
                context.read<OrderProvider>().ordersFinished(selectedOrder);
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
          ),
          const SizedBox(height: 10),
        ],
      );
    },
  );
}
