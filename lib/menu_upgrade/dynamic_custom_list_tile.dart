import 'package:billapp/menu_upgrade/menu_function.dart';
import 'package:billapp/models/products.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicCustomListTile extends StatefulWidget {
  const DynamicCustomListTile({super.key, required this.activeProduct});
  final ProductModel activeProduct;

  @override
  State<DynamicCustomListTile> createState() => _DynamicCustomListTileState();
}

class _DynamicCustomListTileState extends State<DynamicCustomListTile> {
  List<ProductModel> selectedProducts = [];

  int orderedAmount = 0;
  @override
  Widget build(BuildContext context) {
    final ProductModel product = widget.activeProduct;

    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    if (billAppProvider.menuMode == MenuMode.customer) {
      return ListTile(
        title: FittedBox(
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 40,
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                if (orderedAmount > 0) {
                  orderedAmount--;
                  setState(() {});
                  selectedProducts.remove(widget.activeProduct);
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
                orderedAmount++;
                setState(() {});
                if (!selectedProducts.contains(widget.activeProduct)) {
                  selectedProducts.add(widget.activeProduct);
                }
              },
            ),
          ],
        ),
      );
    } else {
      return ListTile(
          title: FittedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 150,
                  height: 30,
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
              ],
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              iconsUpdatePage(
                  context,
                  product.id,
                  product.name, // Ürün adını alın
                  product.price.toString(), // Ürün fiyatını alın
                  product.liter,
                  product.categoryId); // productId'yi burada alıyoruz);
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
}
