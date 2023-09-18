import 'package:billapp/models/model_base.dart';

class TableModel extends ModelBase {
  late String id;
  late String name;

  TableModel({required String name, required String id});

  TableModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    name = data['name'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
