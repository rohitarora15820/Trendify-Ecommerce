import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/controller/products/image_controller.dart';

import '../model/product_model.dart';
import '../model/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variatble
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// Select Attribute and Variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    // When attribute is selected then ass to selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
        (e) => _isSameAttributeValues(e.attributeValues, selectedAttributes),
        orElse: () => ProductVariationModel.empty());

    // Show the selected Variation image as a Main Page
    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQtyInCart.value = cartController
          .getVariationQtyInCart(product.id, selectedVariation.id);
    }

    //assign
    this.selectedVariation.value = selectedVariation;

    getProductVariationStatus();
  }

  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    // if selected attributes length not equal to variation attributes then return false
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (var i in variationAttributes.keys) {
      if (variationAttributes[i].length != selectedAttributes[i].length) {
        return false;
      }
    }
    return true;
  }

  // Check Attribute Avaliablity
  Set<dynamic> getAttributeAvaliablityInVariation(
      List<ProductVariationModel> variation, String attributeName) {
    final availableAttributesValues = variation
        .where((element) =>
            element.attributeValues[attributeName] != null && element.stock > 0)
        .map((e) => e.attributeValues[attributeName])
        .toSet();
    return availableAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// Check Product Variation Stock Status
  void getProductVariationStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? "In Stock" : "Out Stock";
  }

  // reset values
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
