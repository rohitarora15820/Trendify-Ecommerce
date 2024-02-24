

import 'dart:developer';

import 'package:get/get.dart';
import 'package:tstore/data/repositories/products/product_repository.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../../data/repositories/brands/brand_repository.dart';
import '../model/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  RxBool isLoading = true.obs;
  final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());
  final categoryUploadLoading = false.obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // Load Brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);



      //Filter brand List
      featureBrands.assignAll(
          allBrands.where((p0) => p0.isFeatured!).take(8).toList());
      log(featureBrands.toString());
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  // Get brand specific Products from data source
  Future<List<ProductModel>> getBrandProducts(String brandId)async{
    try{
      final products=await ProductRepository.instance.getProductsForBrand(brandId: brandId);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }


  }
  //Upload
  Future<void> uploadBrandData(List<BrandModel> categories)async{
    try{
      categoryUploadLoading.value=true;
      await brandRepository.uploadDummyData(categories);
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your Category Data has been updated successfully!");
    }catch (e) {

      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      categoryUploadLoading.value=false;
    }

  }
}
