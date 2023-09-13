import 'package:billapp/MainFood/firebase/order_finised.dart';
import 'package:billapp/MainFood/firebase/order_products_firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderProductsPage extends StatefulWidget {
  const OrderProductsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderProductsPage> createState() => _OrderProductsPageState();
}

class _OrderProductsPageState extends State<OrderProductsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF260900),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: FittedBox(
          child: Row(
            children: [
              Text(
                ' Masalar',
                style: GoogleFonts.judson(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController, // TabController'ı ekleyin
          tabs: const [
            Tab(text: "Sipariş Bekleyenler"),
            Tab(text: "Ödemesi Alınanlar"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // TabController'ı ekleyin
        children: const [
          // "Sipariş Bekleyenler" içeriği buraya gelecek
          OrderProductsFirebase(isWaiting: true), // Örnek: true sipariş bekleyenleri gösterir
          // "Siparişi Onaylananlar" içeriği buraya gelecek

          OrderFinisedFirebase(isWaiting: true), // Örnek: false siparişi onaylananları gösterir
        ],
      ),
    );
  }
}
