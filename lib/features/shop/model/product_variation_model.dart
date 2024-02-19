class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  double price;
  double salePrice;
  int stock;
  Map<String, dynamic> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = "",
    this.image = "",
    this.description = "",
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
  });

  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  Map<String, dynamic> toMap() {
    return {
      'Id': this.id,
      'SKU': this.sku,
      'Image': this.image,
      'Description': this.description,
      'Price': this.price,
      'SalePrice': this.salePrice,
      'Stock': this.stock,
      'AttributeValues': this.attributeValues,
    };
  }

  factory ProductVariationModel.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: map['Id'] ??"",
      sku: map['SKU'] ??"",
      image: map['Image'] ??"",
      description: map['Description'] ??'',
      price:double.parse((map['Price']??0.0).toString()),
      salePrice:double.parse((map['SalePrice']??0.0).toString()),
      stock: map['Stock'] ??0,
      attributeValues:Map<String, dynamic>.from(map['AttributeValues']) ,
    );
  }
}
