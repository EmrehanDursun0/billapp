import 'package:billapp/menu_update/menu_function.dart';
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
  @override
  Widget build(BuildContext context) {
    int productCount = 0;
    final ProductModel product = widget.activeProduct;

    final BillAppProvider billAppProvider = context.watch<BillAppProvider>();
    if (billAppProvider.menuMode == MenuMode.customer) {
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                if (productCount > 0) {
                  productCount--;
                  setState(() {});
                }
              },
            ),
            Text(productCount.toString(),
                style: GoogleFonts.judson(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                productCount++;
                setState(() {});
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
