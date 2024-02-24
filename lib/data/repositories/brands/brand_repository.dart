import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/model/brand_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/t_firebase_storage_service.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get All Categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection("Brands").get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }

// Get Brands For Categories


// Upload Dummy Data
// Upload Categories to Firebase Firestore
  Future<void> uploadDummyData(List<BrandModel> categories) async {
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
        await storage.uploadImageData('Brands', file, category.name);

        category.image = url;

        // Store in Firestore
        await _db
            .collection('Brands')
            .doc(category.id)
            .set(category.toMap());
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
