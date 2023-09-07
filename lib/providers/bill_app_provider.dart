import 'package:billapp/providers/categoires_provider.dart';
import 'package:billapp/providers/product_provider.dart';
import 'package:billapp/providers/table_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillAppProvider extends ChangeNotifier {
  Future<void> initializeApplication(BuildContext context) async {
    try {
      await Future.wait([
        context.read<CategoryProvider>().fetchAllCategories(),
        context.read<TableProvider>().fetchAllTables(),
        context.read<ProductProvider>().fetchAllProducts(context),
      ]);
      debugPrint('****** ****** İşlem Başarılı ****** ******');
    } catch (e) {
      debugPrint('------- ****** İşlem Başarısız ****** -------');
    }
  }
}
