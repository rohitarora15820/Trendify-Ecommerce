class CartItemModel {
  String productId;
  String title;
  String brandName;
  double price;
  String? image;
  int quantity;
  String variationId;
  Map<String, dynamic>? selectedVariation;

  CartItemModel({
    required this.productId,
    this.title = "",
    this.brandName='',
    this.price = 0.0,
    this.image,
    required this.quantity,
    this.variationId = "",
    this.selectedVariation,
  });

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'title': this.title,
      'brandName': this.brandName,
      'price': this.price,
      'image': this.image,
      'quantity': this.quantity,
      'variationId': this.variationId,
      'selectedVariation': this.selectedVariation,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['productId'] as String,
      title: map['title'] as String,
      brandName: map['brandName'] as String,
      price: map['price']?.toDouble(),
      image: map['image'] as String,
      quantity: map['quantity'] as int,
      variationId: map['variationId'] as String,
      selectedVariation: map['selectedVariation'] != null
          ? Map<String, String>.from(map['selectedVariation'])
          : null,
    );
  }
}
