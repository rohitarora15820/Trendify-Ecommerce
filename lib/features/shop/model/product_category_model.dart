import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel {
  String productId;
  String categoryId;

  ProductCategoryModel({
    required this.productId,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'categoryId': this.categoryId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data=snapshot.data() as Map<String,dynamic>;
    return ProductCategoryModel(
      productId: data['productId'] ??"",
      categoryId: data['categoryId'] ??"",
    );
  }
}

