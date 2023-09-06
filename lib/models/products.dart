import 'package:billapp/models/category.dart';
import 'package:billapp/models/model_base.dart';

class ProductModel extends ModelBase {
  late String id;
  late String categoryId;
  CategoryModel? category;
  late String name;
  double? price;

  ProductModel();

  ProductModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    categoryId = data['categoryId'];
    category = data['category'] == null
        ? null
        : CategoryModel.fromMap(data['category']);
    name = data['name'];
    price = data['price'] == null
        ? null
        : double.tryParse(data['price'].toString());
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'category': category?.toMap(),
      'price': price,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
