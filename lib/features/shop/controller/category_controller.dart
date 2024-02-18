import 'dart:developer';

import 'package:get/get.dart';
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
for(var i in categoryList){
  log(i.isFeatured.toString());
}

      //Filter categories List
      featuredCategoryList.assignAll(
          categoryList.where((p0) => p0.isFeatured ).take(8).toList());
      log(featuredCategoryList.toString());

      
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

// Get Category or SubCategory Products
}
