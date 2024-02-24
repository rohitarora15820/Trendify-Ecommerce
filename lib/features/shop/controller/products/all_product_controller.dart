import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/products/product_repository.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/popups/loader.dart';

class AllPProductController extends GetxController {
  static AllPProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = "".obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];

      final products = await repository.fetchProductsByQuery(query);
      return products;
    } catch (e) {
      TLoaders.sucessSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case "Name":
        products.sort((a, b) => a.title.compareTo(b.title));
        break;

      case "Higher Price":
        products.sort((a, b) => b.price!.compareTo(a.price!));
        break;

      case "Lower Price":
        products.sort((a, b) => a.price!.compareTo(b.price!));
        break;

      case "Sales":
        products.sort((a, b) {
          if (b.salePrice > 0) {
            return b.salePrice.compareTo(a.salePrice);
          } else if (a.salePrice > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;

      case "Newest":
        products.sort((a, b) => a.date!.compareTo(b.date!));
        break;

        default:
          products.sort((a, b) => a.title.compareTo(b.title));
    }
  }

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts("Name");
  }
}
