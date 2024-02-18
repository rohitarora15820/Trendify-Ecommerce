import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TFirebaseStorageService extends GetxController {
  static TFirebaseStorageService get instance => Get.find();

  // variables
  final storage = FirebaseStorage.instance;

// Upload Local Assets from IDE
// Return Uint8List containing image Data
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw "Error Loading image data $e";
    }
  }

  // Upload imgae to Firestore &
// return Downloaded url

  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      final ref = storage.ref(path).child(name);
      await ref.putData(image);
      final url = ref.getDownloadURL();
      return url;
    } catch (e) {
      if(e is FirebaseException){
        throw "FirebaseException: ${e.message}";
      }
      else if( e is SocketException){
        throw "SocketException: ${e.message}";
      } else if( e is PlatformException){
        throw "PlatformException: ${e.message}";
      }
      else{
        throw "Something went wrong! Please try again";
      }

    }
  }

  Future<String> uploadImageFile(
      String path, XFile image,) async {
    try {
      final ref = storage.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = ref.getDownloadURL();
      return url;
    }  catch (e) {
      if(e is FirebaseException){
        throw "FirebaseException: ${e.message}";
      }
      else if( e is SocketException){
        throw "SocketException: ${e.message}";
      } else if( e is PlatformException){
        throw "PlatformException: ${e.message}";
      }
      else{
        throw "Something went wrong! Please try again";
      }

    }
  }
}
