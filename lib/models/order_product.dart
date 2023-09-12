import 'package:billapp/models/model_base.dart';
import 'package:billapp/models/products.dart';
 

class OrderProductModel extends ModelBase {
  late String id;
  late String orderId;
  late String productId;
  ProductModel? product;
  late int orderedAmount;

  OrderProductModel({required String id, required String orderId, required String productId, required int orderedAmount});

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
