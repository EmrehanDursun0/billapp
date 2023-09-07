import 'package:billapp/models/category.dart';
import 'package:billapp/models/model_base.dart';

class ProductModel extends ModelBase {
  late String id;
  late int categoryId;
  CategoryModel? category;
  late String name;
  double? price;
  late String liter;

  ProductModel();

  ProductModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    categoryId = int.parse(data['categoryId']);
    category = data['category'] == null ? null : CategoryModel.fromMap(data['category']);
    name = data['name'];
    price = data['price'] == null ? null : double.tryParse(data['price'].toString());
    liter = data['liter'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'category': category?.toMap(),
      'price': price,
      'liter':liter,

    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
