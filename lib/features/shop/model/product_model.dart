
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tstore/features/shop/model/brand_model.dart';
import 'package:tstore/features/shop/model/product_attribute_model.dart';
import 'package:tstore/features/shop/model/product_variation_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double? price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.stock,
    this.sku,
    this.price,
    required this.title,
    this.date,
   this.salePrice=0.0,
    required this.thumbnail,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.images,
    required this.productType,
    this.productAttributes,
    this.productVariations,
  });
@override
  String convertToString() {
    // TODO: implement toString
    return 'Products: $id, $title';
  }

 String get converttInstancetoString=> convertToString();
static ProductModel empty()=> ProductModel(id: '', stock: 0, title: '', thumbnail: '', productType: '');


  Map<String, dynamic> toMap() {
    return {
      'Stock': this.stock,
      'SKU': this.sku,
      'Price': this.price,
      'Title': this.title,
      'SalePrice': this.salePrice,
      'Thumbnail': this.thumbnail,
      'IsFeatured': this.isFeatured,
      'Brand': brand!.toMap(),
      'Description': this.description,
      'CategoryId': this.categoryId,
      'Images': this.images ?? [],
      'ProductType': this.productType,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toMap()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toMap()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final map = document.data()!;
    // if(map.data() != null) return ProductModel.empty();
    return ProductModel(
      id: document.id,
      stock: map['Stock'] ?? 0,
      sku: map['SKU'] ?? '',
      price: double.parse((map['Price'] ?? 0.0).toString()),
      title: map['Title']??'',
      salePrice: double.parse((map['SalePrice'] ?? 0.0).toString()),
      thumbnail: map['Thumbnail'] ?? '',
      isFeatured: map['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(map['Brand']),
      description: map['Description'] ?? "",
      categoryId: map['CategoryId'] ?? '',
      images: map['Images'] != null ? List<String>.from(map['Images']) : [],
      productType: map['ProductType'] ?? '',
      productAttributes: (map['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromMap(e))
          .toList(),
      productVariations: (map['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromMap(e))
          .toList(),
    );
  }
  factory ProductModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Object?> data) {
    final map = data.data() as Map<String, dynamic>;
    return ProductModel(
      id: data.id,
      stock: map['Stock'] ?? 0,
      sku: map['SKU'] ?? '',
      price: double.parse((map['Price'] ?? 0.0).toString()),
      title: map['Title'],
      salePrice: double.parse((map['SalePrice'] ?? 0.0).toString()),
      thumbnail: map['Thumbnail'] ?? '',
      isFeatured: map['IsFeatured'] ?? false,
      brand: BrandModel.fromJson(map['Brand']),
      description: map['Description'] ?? "",
      categoryId: map['CategoryId'] ?? '',
      images: map['Images'] != null ? List<String>.from(map['Images']) : [],
      productType: map['ProductType'] ?? '',
      productAttributes: (map['ProductAttributes'] as List<dynamic>)
          .map((e) => ProductAttributeModel.fromMap(e))
          .toList(),
      productVariations: (map['ProductVariations'] as List<dynamic>)
          .map((e) => ProductVariationModel.fromMap(e))
          .toList(),
    );
  }


}
