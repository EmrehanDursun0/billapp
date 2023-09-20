 
import 'package:billapp/case_menu/case_menu_page.dart';
import 'package:billapp/menu_update/menu_function.dart'; 
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:billapp/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/order_product.dart';
import '../orders/orders_page.dart';
import 'dynamic_menu_page.dart';

class DynamicCategoriesPageButton extends StatelessWidget {
  const DynamicCategoriesPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    if (billAppProvider.menuMode == MenuMode.customer) {
      return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const OrderPage(
              selectedTable: '',
            ),
          ));
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFE0A66B),
          fixedSize: const Size(230, 60),
        ),
        child: Text('Siparişlerim',
            style: GoogleFonts.judson(
              fontSize: 27,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CaseHomePage(
                      selectedTable: '',
                    )),
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFE0A66B),
          fixedSize: const Size(230, 60),
        ),
        child: Text('Geri Dön',
            style: GoogleFonts.judson(
              fontSize: 27,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      );
    }
  }
}

class DynamicPageButton extends StatelessWidget {
  final String categoryId;
  final String id;
  final List<OrderProductModel>? selectedProducts;

  const DynamicPageButton({super.key, required this.categoryId, required this.id, this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();

    if (billAppProvider.menuMode == MenuMode.customer) {
      return ElevatedButton(
        onPressed: () async {
          final OrderProvider orderProvider = context.read<OrderProvider>();
          await orderProvider.saveOrders(context, selectedProducts!);
          if (context.mounted) {
            Navigator.push(
                context,
                (MaterialPageRoute(
                  builder: (context) => const DynamicMenuPage(),
                )));
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
        child: Text('Siparişe Devam Et',
            style: GoogleFonts.judson(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          dynamicUpdatePage(context, id, '', '', '', categoryId, Buttonmode.added);
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          foregroundColor: Colors.black,
          backgroundColor: const Color(0xFFE0A66B),
          fixedSize: const Size(230, 60),
        ),
        child: Text('Yemek Ekle',
            style: GoogleFonts.judson(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      );
    }
  }
}
