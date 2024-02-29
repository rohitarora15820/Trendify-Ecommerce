import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/variation_controller.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/enums.dart';
import 'package:tstore/utils/local_storage/storage_utility.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../model/cart_item_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // Variables
  RxInt noOfCartItems = 0.obs;
  RxInt productQtyInCart = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;


  CartController(){
    loadCartItems();
  }

// Add Item in Cart
  void addToCart(ProductModel product) {
    // qty check
    if (productQtyInCart.value < 1) {
      TLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Selected?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      TLoaders.customToast(message: 'Select Variation');
      return;
    }

    // Out of Stock
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Oh Snap!', message: "Selected variation is Out of stock");
        return;
      }
    } else {
      if (product.stock < 1) {
        TLoaders.warningSnackBar(
            title: 'Oh Snap!', message: "Selected variation is Out of stock");
        return;
      }
    }

    // convert to cartmodel with qty
    final selectedCartItem = convertToCartItem(product, productQtyInCart.value);

    // Check if already Added in Cart
    int index = cartItems.indexWhere((element) =>
        element.productId == selectedCartItem.productId &&
        element.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // Already in Cart
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCartItems();

    TLoaders.customToast(message: "Your Product has been added to the cart");
  }

  void addOneToCart(CartItemModel model) {
    int index=cartItems.indexWhere((p0) => p0.productId == model.productId && p0.variationId == model.variationId);

    if(index >= 0){
      cartItems[index].quantity += 1;
    }else{
      cartItems.add(model);
    }
    updateCartItems();
  }

  void removeOneToCart(CartItemModel model) {
    int index=cartItems.indexWhere((p0) => p0.productId == model.productId && p0.variationId == model.variationId);

    if(index >= 0){
      if(cartItems[index].quantity > 1){
      cartItems[index].quantity -= 1;

      }else{
        // show dialog before completing removing
        cartItems[index].quantity == 1? removeFromCartDialog(index):cartItems.removeAt(index);
      }
      updateCartItems();
    }

  }

  CartItemModel convertToCartItem(ProductModel product, int qty) {
    if (product.productType == ProductType.single.toString()) {
      // reset variation in case of single product
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : product.salePrice > 0.0
            ? product.salePrice
            : product.price;

    return CartItemModel(
        productId: product.id,
        quantity: qty,
        title: product.title,
        image: isVariation ? variation.image : product.thumbnail,
        price: price!,
        variationId: variation.id,
        brandName: product.brand != null ? product.brand!.name : "",
        selectedVariation: isVariation ? variation.attributeValues : null);
  }

  void updateCartItems() {
    upadateCartTotal();
    saveCartItems();
    cartItems.refresh();
  }

  void upadateCartTotal() {
    double calculatedTotalCartPrice = 0.0;
    int calculatedTotalCartQty = 0;

    for (var item in cartItems) {
      calculatedTotalCartPrice += (item.price) * item.quantity.toDouble();
      calculatedTotalCartQty += item.quantity;
    }

    totalCartPrice.value = calculatedTotalCartPrice;
    noOfCartItems.value = calculatedTotalCartQty;
  }

  void saveCartItems() {
    final items = cartItems.map((element) => element.toMap()).toList();
    TLocalStorage.instance().saveData('cartItems', items);
  }

  void loadCartItems() {
    final cartItemsStrings =
        TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemsStrings != null) {
      cartItems.map(
          (element) => CartItemModel.fromMap(element as Map<String, dynamic>));
      updateCartItems();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((p0) => p0.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQtyInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (p0) => p0.productId == productId && p0.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart(){
    productQtyInCart.value = 0;
    cartItems.clear();
    updateCartItems();
  }

  removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: "Remove Product",
      middleText: "Are you sure you want to remove this product?",
      onConfirm: (){
        cartItems.removeAt(index);
        updateCartItems();
        TLoaders.customToast(message: "Product removed from cart");
        Get.back();
      },
      onCancel: (){
        Get.back();
      }
    );
  }

  void updateAlreadyAddedProductCount(ProductModel product){

    if(product.productType == ProductType.single.toString()){
      productQtyInCart.value=getProductQuantityInCart(product.id);
    }
    else{
      final variationId=variationController.selectedVariation.value.id;
      if(variationId.isNotEmpty){
        productQtyInCart.value=getVariationQtyInCart(product.id, variationId);
      }
      else{
        productQtyInCart.value=0;
      }
    }
  }
}
