// ignore_for_file: use_build_context_synchronously, unused_local_variable
import 'package:billapp/models/products.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductUpdatePage extends StatefulWidget {
  final String collectionName;
  final String id;
  const ProductUpdatePage({
    Key? key,
    required this.collectionName,
    required this.id,
  }) : super(key: key);

  @override
  ProductUpdatePageState createState() => ProductUpdatePageState();
}

class ProductUpdatePageState extends State<ProductUpdatePage> {
  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = context.watch<ProductProvider>();
    productProvider.fetchAllProducts(context);
    final products = productProvider.allProducts
        .where((product) => product.categoryId == widget.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deneme'),
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
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  ProductModel activeProduct = products[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text(activeProduct.name),
                      ),
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}



 // ProductProvider'ı ekleyin

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Verileri çekmek için ProductProvider'ı kullanın
//     Provider.of<ProductProvider>(context, listen: false).fetchAllProducts(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ürün Listesi'),
//       ),
//       body: productProvider.allProducts.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: productProvider.allProducts.length,
//               itemBuilder: (ctx, index) {
//                 final product = productProvider.allProducts[index];
//                 return ListTile(
//                   title: Text(product.name),
//                   subtitle: Text(product.price?.toString() ?? 'Fiyat bilgisi yok'),
//                   // Diğer bilgileri de gösterebilirsiniz
//                 );
//               },
//             ),
//     );
//   }
// }

