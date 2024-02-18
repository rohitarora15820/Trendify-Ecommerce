import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String brandId;
  String categoryId;

  BrandCategoryModel({
    required this.brandId,
    required this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'brandId': this.brandId,
      'categoryId': this.categoryId,
    };
  }

  factory BrandCategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data=snapshot.data() as Map<String,dynamic>;
    return BrandCategoryModel(
      brandId: data['brandId'] ??"",
      categoryId: data['categoryId'] ??"",
    );
  }
}

