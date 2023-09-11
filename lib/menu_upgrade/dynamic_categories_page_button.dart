import 'package:billapp/MainFood/orders_page.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
        onPressed: () {},
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
