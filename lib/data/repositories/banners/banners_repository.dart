import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/model/banner_model.dart';

import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../services/t_firebase_storage_service.dart';

class BannerRepository extends GetxController{
  static BannerRepository get instance=> Get.find();

  // Variables
  final _db=FirebaseFirestore.instance;


  // Get All banners
Future<List<BannerModel>> fetchBanners() async{
  try{
    final result=await _db.collection('Banners').where('Active', isEqualTo: true).get();
    return result.docs.map((e) => BannerModel.fromSnapshot(e)).toList();

  }on FirebaseException catch (e) {
    throw TFirebaseException(e.code).message;
  } on PlatformException catch (e) {
    throw TPlatformException(e.code).message;
  } catch (e) {
    throw "Something went wrong. Please try again later";
  }

  }

// Upload banner to Cloud Storage
// Upload Categories to Firebase Firestore
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      // Upload All Category along with images
      final storage = Get.put(TFirebaseStorageService());

      //Loop through each category
      for (var banner in banners) {
        // get image Data link from local storage
        final file = await storage.getImageDataFromAssets(banner.imageUrl);


        // Upload image & get url
        final url =
        await storage.uploadImageData('Banners', file, banner.imageUrl);

        banner.imageUrl = url;

        // Store in Firestore
        await _db
            .collection('Banners')
            .doc()
            .set(banner.toMap());
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