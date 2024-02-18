import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  int productCount;
  bool isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productCount,
    required this.isFeatured,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'productCount': this.productCount,
      'isFeatured': this.isFeatured,
    };
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data=snapshot.data() as Map<String,dynamic>;
    return BrandModel(
      id: snapshot.id,
      name: data['name'] ??'',
      image: data['image'] ??"",
      productCount: data['productCount'] ?? 0,
      isFeatured: data['isFeatured'] ?? false,
    );
  }
}

