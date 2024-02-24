import 'package:get/get.dart';
import 'package:tstore/data/repositories/products/product_repository.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/enums.dart';
import 'package:tstore/utils/popups/loader.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  // variables
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  final isLoading = false.obs;
  final productUploadLoading = false.obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  // fetch products
  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      // Fetch Products
      final result = await productRepository.getAllProducts();

      // update list
      featuredProducts.assignAll(result);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'Failed to fetch featured products', message: e.toString());
    } finally {
      isLoading.value = false;
    }
    ;
  }

// Upload dummy records
  Future<void> uploadProductData(List<ProductModel> products) async {
    try {
      productUploadLoading.value = true;
      await productRepository.uploadDummyData(products);
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your Category Data has been updated successfully!");
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      productUploadLoading.value = false;
    }
  }

  // get product price for variations
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // if no variation exist return simple price
    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toString();
    } else {
      for (var variation in product.productVariations!) {
        // Determine price to consider
        double priceToConsider =
            variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update prices
        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      // if same return single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      } else {
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }

  // Calculate Sale Percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // Get Product Stock
  String getProductStock(int stock){
    return stock > 0 ? "IN Stock":"Out Stock";
  }
}
