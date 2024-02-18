import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      this.parentId = '',
      required this.isFeatured});

  // Empty Helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  Map<String, dynamic> toJson() {
    return {
      'Name': this.name,
      'Image': this.image,
      'ParentId': this.parentId,
      'IsFeatured': this.isFeatured,
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> map) {
    if (map.data() != null) {
      final data = map.data()!;
      return CategoryModel(
        id: map.id,
        name: data['Name'] ?? "",
        image: data['Image'] ?? "",
        parentId: data['ParentId'] ?? "",
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
