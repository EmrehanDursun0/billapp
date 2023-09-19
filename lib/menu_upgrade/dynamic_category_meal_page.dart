import 'package:billapp/models/order_product.dart';
import 'package:billapp/providers/bill_app_provider.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import 'dynamic_categories_page_button.dart';
import 'menu_function.dart';

class DynamicCategoryItemsPage extends StatefulWidget {
  final String collectionName;
  final String categoryId;
  const DynamicCategoryItemsPage({
    Key? key,
    required this.collectionName,
    required this.categoryId,
  }) : super(key: key);

  @override
  DynamicCategoryItemsPageState createState() =>
      DynamicCategoryItemsPageState();
}

class DynamicCategoryItemsPageState extends State<DynamicCategoryItemsPage> {
  List<OrderProductModel> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = context.watch<ProductProvider>();
    final products = productProvider.allProducts
        .where((product) => product.categoryId == widget.categoryId)
        .toList();

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
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      ProductModel product = products[index];
                      final BillAppProvider billAppProvider =
                          context.watch<BillAppProvider>();
                      if (billAppProvider.menuMode == MenuMode.customer) {
                        return ListTile(
                          title: Column(
                            children: [
                              const SizedBox(height: 20),
                              FittedBox(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 50,
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
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove,
                                    color: Colors.white),
                                onPressed: () {
                                  final OrderProductModel? productModel =
                                      checkProduct(product);
                                  if (productModel == null) {
                                    return;
                                  }
                                  if (productModel.orderedAmount == 1) {
                                    selectedProducts.removeWhere(
                                        (sp) => sp.id == productModel.id);
                                  } else {
                                    productModel.orderedAmount--;
                                  }
                                  setState(() {});
                                },
                              ),
                              Text(
                                getProductOrderedAmount(product),
                                style: GoogleFonts.judson(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  final OrderProductModel? productModel =
                                      checkProduct(product);
                                  if (productModel == null) {
                                    OrderProductModel product0 =
                                        OrderProductModel.empty();
                                    product0.productId = product.id;
                                    product0.product = product;
                                    product0.orderedAmount = 1;
                                    selectedProducts.add(product0);
                                  } else {
                                    productModel.orderedAmount++;
                                  }
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 180,
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
                            trailing: IconButton(
                              onPressed: () {
                                dynamicUpdatePage(
                                    context,
                                    product.id,
                                    product.name,
                                    product.price.toString(),
                                    product.liter,
                                    product.categoryId,
                                    Buttonmode.update);
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
                    },
                  ),
                ),
                DynamicPageButton(
                  categoryId: widget.categoryId,
                  id: '',
                  selectedProducts: selectedProducts,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  OrderProductModel? checkProduct(ProductModel product) {
    if (selectedProducts.isEmpty) {
      return null;
    }
    final OrderProductModel? orderProductModel =
        selectedProducts.firstWhereOrNull((sp) => sp.productId == product.id);
    return orderProductModel;
  }

  String getProductOrderedAmount(ProductModel product) {
    final OrderProductModel? productModel = checkProduct(product);
    if (productModel == null) {
      return '0';
    } else {
      return productModel.orderedAmount.toString();
    }
  }
}
