import 'package:billapp/models/order.dart';
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
                            ), // onTap ile seçilen masanın siparişlerini görüntülemek için bir işlev çağırın
                            onTap: () {
                              _showTableOrders(context, order);
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
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

void _showTableOrders(BuildContext context, OrderModel selectedOrder) {
  // Seçilen masanın siparişlerini içeren bir sayfaya geçiş yapın
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TableOrdersPage(selectedOrder: selectedOrder),
    ),
  );
}

class TableOrdersPage extends StatelessWidget {
  final OrderModel selectedOrder;

  const TableOrdersPage({super.key, required this.selectedOrder});

  @override
  Widget build(BuildContext context) {
    // Seçilen masanın siparişlerini göstermek için gerekli arayüzü oluşturun
    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedOrder.table!.name} Siparişleri"), // Başlık olarak masa adını kullanabilirsiniz
      ),
      body: Center(
        child: Container(child: const Text("")), // Seçilen masanın siparişlerini gösteren bir Widget ekleyin
      ),
    );
  }
}
