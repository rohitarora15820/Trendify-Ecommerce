import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:tstore/data/repositories/products/product_repository.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/local_storage/storage_utility.dart';
import 'package:tstore/utils/popups/loader.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  /// Variables
  ///
  final favourites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  // Method to initialize Favourites form local Storage
  Future<void> initFavourites() async {
    final json = TLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(
          storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }
  
  void toggleFavouriteProduct(String productId)async{
    if(!favourites.containsKey(productId)){
      favourites[productId] = true;
      saveFavouritesToStorage();
      log("added");
      TLoaders.customToast(message: 'Product has been added to  the Wishlist');
    }
    else{
      TLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavouritesToStorage();
      favourites.refresh();
      log("removed");
      TLoaders.customToast(message: 'Product has been removed from the Wishlist');

    }
  }

  void saveFavouritesToStorage() {
    final encodedFavourites=json.encode(favourites);
    TLocalStorage.instance().saveData('favourites', encodedFavourites);
  }

  Future<List<ProductModel>> getFavouritesProduct()async{
    return await ProductRepository.instance.getFavouritesProducts(favourites.keys.toList());
  }
}
