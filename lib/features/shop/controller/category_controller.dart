import 'dart:developer';

import 'package:get/get.dart';
import 'package:tstore/data/repositories/products/product_repository.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../../data/repositories/categories/category_repository.dart';
import '../model/category_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final categoryLoading = false.obs;
  final categoryUploadLoading = false.obs;
  final RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategoryList = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

// Load Category Data
  Future<void> fetchCategories() async {
    try {
      // show loader
      categoryLoading.value = true;

      // fetch categories
      final categories = await _categoryRepository.getAllCategories();


      // update list
      categoryList.assignAll(categories);


      //Filter categories List
      featuredCategoryList.assignAll(
          categoryList.where((p0) => p0.isFeatured && p0.parentId.isEmpty).take(8).toList());


      
    } catch (e) {

      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      categoryLoading.value=false;
    }
  }

  Future<void> uploadCategoryData(List<CategoryModel> categories)async{
    try{
      categoryUploadLoading.value=true;
      await _categoryRepository.uploadDummyData(categories);
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your Category Data has been updated successfully!");
    }catch (e) {

      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      categoryUploadLoading.value=false;
    }

  }

// Load Selected Category Data
  Future<List<CategoryModel>> getSubCategoryProducts({required String categoryId,int limit=4})async{
    try{
      final products=await _categoryRepository.getProductsForSubCategory(categoryId: categoryId);
      return products;
    }catch (e) {
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }




  }

// Get Category or SubCategory Products
Future<List<ProductModel>> getCategoryProducts({required String categoryId,int limit=4})async{

    final products=await ProductRepository.instance.getProductsForCategory(categoryId:categoryId,limit:limit);
    return products;

}
}
