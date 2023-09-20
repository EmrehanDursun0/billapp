import 'package:billapp/models/order.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderFinisedFirebase extends StatefulWidget {
  const OrderFinisedFirebase({Key? key, required bool isWaiting}) : super(key: key);

  @override
  OrderFinisedFirebaseState createState() => OrderFinisedFirebaseState();
}

class OrderFinisedFirebaseState extends State<OrderFinisedFirebase> {
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider = context.read<OrderProvider>();
    return FutureBuilder(
      future: orderProvider.orderfinish(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
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
                            onTap: () {},
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
