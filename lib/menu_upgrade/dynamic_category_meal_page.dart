// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:billapp/menu_upgrade/dynamic_categories_page_button.dart';
import 'package:billapp/menu_upgrade/dynamic_custom_list_tile.dart';
import 'package:billapp/models/products.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DynamicCategoryItemsPage extends StatefulWidget {
  final String collectionName;
  final String categoryId;
  const DynamicCategoryItemsPage({
    Key? key,
    required this.collectionName,
    required this.categoryId,
  }) : super(key: key);

  @override
  DynamicCategoryItemsPageState createState() => DynamicCategoryItemsPageState();
}

class DynamicCategoryItemsPageState extends State<DynamicCategoryItemsPage> {
  @override
  Widget build(BuildContext context) {
    // final ProductModel product = widget.activeProduct;
    final String id;
    final ProductProvider productProvider = context.watch<ProductProvider>();
    productProvider.fetchAllProducts(context);
    final products = productProvider.allProducts.where((product) => product.categoryId == widget.categoryId).toList();

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
        title: Text(
          widget.collectionName,
          style: GoogleFonts.judson(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel activeProduct = products[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [DynamicCustomListTile(activeProduct: activeProduct)],
                      );
                    },
                  ),
                ),
                DynamicPageButton(
                  categoryId: widget.categoryId,
                  id: '',
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
