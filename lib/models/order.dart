import 'package:billapp/models/model_base.dart';
import 'package:billapp/models/order_product.dart';
import 'package:billapp/models/table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel extends ModelBase {
  late String id;
  late String tableId;
  TableModel? table;
  List<OrderProductModel> orderProducts = [];
  Timestamp? timeStamp;
  double? totalPrice;
  String? hour;
  OrderProductModel? orderedAmount;

  OrderModel();

  OrderModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    tableId = data['tableId'];
    table = data['table'] == null ? null : TableModel.fromMap(data['table']);
    orderProducts = data['orderProducts'] == null ? [] : List.from(data['orderProducts']).map((x) => OrderProductModel.fromMap(x)).toList();
    timeStamp = data['timeStamp'];
    dateTime = timeStamp?.toDate();
    hour = "${dateTime?.hour}:${dateTime?.minute} ";
    totalPrice = data['totalPrice'] == null ? null : double.tryParse(data['totalPrice'].toString());
    orderedAmount = data['orderedAmount'] == null ? null : OrderProductModel.fromMap(data['orderedAmount']);
  }

  get orderDate => null;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tableId': tableId,
      'table': table?.toMap(),
      'orderProducts': orderProducts.map((x) => x.toMap()).toList(),
      'timeStamp': timeStamp,
      'totalPrice': totalPrice,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }

  DateTime? dateTime;
}
