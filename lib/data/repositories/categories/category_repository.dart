import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore/features/authentication/view/login/widgets/login_divider.dart';
import 'package:tstore/utils/exceptions/firebase_exceptions.dart';

import '../../../features/shop/model/category_model.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/t_firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

// Get All Categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection("Categories").get();
      final categoryList =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return categoryList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }

// Get All SubCategories

// Upload Categories to Firebase Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      // Upload All Category along with images
      final storage = Get.put(TFirebaseStorageService());

      //Loop through each category
      for (var category in categories) {
        log(category.image.toString());
        // get image Data link from local storage
        final file = await storage.getImageDataFromAssets(category.image);


        // Upload image & get url
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        category.image = url;

        // Store in Firestore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }
}
