import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  int? productCount;
  bool? isFeatured;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.productCount,
    this.isFeatured,
  });

  static BrandModel empty()=> BrandModel(id: '', name:'', image: '');

  Map<String, dynamic> toMap() {
    return {
      'Id': this.id,
      'Name': this.name,
      'Image': this.image,
      'ProductCount': this.productCount,
      'IsFeatured': this.isFeatured,
    };
  }

  factory BrandModel.fromJson( Map<String,dynamic> document) {
    final data=document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data["Id"]??"",
      name: data['Name'] ??'',
      image: data['Image'] ??"",
      productCount: data['ProductCount'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
    );
  }


  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> map) {
    if (map.data() != null) {
      final data = map.data()!;
      return BrandModel(
        id: map.id,
        name: data['Name'] ??'',
        image: data['Image'] ??"",
        productCount: data['ProductCount'] ?? 0,
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else {
      return BrandModel.empty();
    }
  }

}

