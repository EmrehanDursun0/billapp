import 'package:billapp/MainFood/orders_page.dart';
import 'package:billapp/case_menu/case_menu_page.dart';
import 'package:billapp/menu_upgrade/dynamic_menu_page.dart';
import 'package:billapp/menu_upgrade/menu_function.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/order_product.dart';
import '../providers/order_provider.dart';

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

class DynamicPageButton extends StatefulWidget {
  final String categoryId;
  final String id;

  const DynamicPageButton({super.key, required this.categoryId, required this.id});

  @override
  State<DynamicPageButton> createState() => _DynamicPageButtonState();
}

class _DynamicPageButtonState extends State<DynamicPageButton> {
  final List<OrderProductModel> selectedProducts = [];
  @override
  Widget build(BuildContext context) {
    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();

    if (billAppProvider.menuMode == MenuMode.customer) {
      return ElevatedButton(
        onPressed: () async {
          await saveOrders(context, selectedProducts);
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              (MaterialPageRoute(
                builder: (context) => const DynamicMenuPage(),
              )));
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
          showMealAdditionDialog(context, widget.id, widget.categoryId);
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
