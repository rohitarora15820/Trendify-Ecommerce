import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/model/product_model.dart';
import 'package:tstore/utils/constants/enums.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/t_firebase_storage_service.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get All Categories
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db
          .collection("Products")
          .where('IsFeatured', isEqualTo: true)
          .limit(2)
          .get();

      final categoryList = snapshot.docs.map((e) {

        return ProductModel.fromSnapshot(e);
      }).toList();

      return categoryList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }

  // Get Product For Brand
  Future<List<ProductModel>> getProductsForBrand({required String brandId,int limit=-1}) async {
    try {
     final querySnapShot=limit == -1? await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).get():
     await _db.collection('Products').where('Brand.Id',isEqualTo: brandId).limit(limit).get();
     final categoryList = querySnapShot.docs.map((e) {

       return ProductModel.fromSnapshot(e);
     }).toList();
      return categoryList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }


  // get Product by Query
  // Get All Categories
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();

      final categoryList = querySnapshot.docs.map((e) {

        return ProductModel.fromQuerySnapshot(e);
      }).toList();

      return categoryList;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }


  // Upload Categories to Firebase Firestore
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload All Category along with images
      final storage = Get.put(TFirebaseStorageService());

      //Loop through each category
      for (var product in products) {
        // get image Data link from local storage
        final file = await storage.getImageDataFromAssets(product.thumbnail);

        // Upload image & get url
        final url = await storage.uploadImageData(
            'Products/Images', file, product.thumbnail.toString());

        product.thumbnail = url;

        // Product List of Images
        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrl = [];
          for (var image in product.images!) {
            // get image local assets
            final assetImage = await storage.getImageDataFromAssets(image);

            // Upload image & get url
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, image);

            //Assign Images
            imageUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imageUrl);
        }

        // Upload Variation Image
        if (product.productType == ProductType.variable.toString()) {
          for (var variation in product.productVariations!) {
            // get image local assets
            final assetImage =
                await storage.getImageDataFromAssets(variation.image);

            // Upload image & get url
            final url = await storage.uploadImageData(
                'Products/Images', assetImage, variation.image);

            // Assign
            variation.image = url;
          }
        }

        // Store in Firestore
        await _db.collection('Products').doc(product.id).set(product.toMap());
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
