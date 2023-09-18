import 'package:billapp/models/model_base.dart';
import 'package:billapp/models/product.dart';

class OrderProductModel extends ModelBase {
  late String id = "0";
  late String orderId = "0";
  late String productId = "0";
  ProductModel? product;
  late int orderedAmount = 0;

  OrderProductModel.empty();

  OrderProductModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    orderId = data['orderId'];
    productId = data['productId'];
    product = data['product'] == null ? null : ProductModel.fromMap(data['product']);
    orderedAmount = data['orderedAmount'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'productId': productId,
      'product': product?.toMap(),
      'orderedAmount': orderedAmount,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
