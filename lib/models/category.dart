import 'package:billapp/models/model_base.dart';

class CategoryModel extends ModelBase {
  String? id;
  String? name;
  String? imagePath;

  CategoryModel.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    id = data['id'];
    name = data['name'];
    imagePath = data['imagePath'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
