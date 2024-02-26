import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/utils/exceptions/platform_exceptions.dart';

import '../../../features/shop/model/address_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> getUserAddress() async {
    try {
      final userId =
          AuthenticationRepository.instance.currentAuthenticatedUser!.uid;
      if (userId.isEmpty) {
        throw "Unable to find user information. Please try again later";
      }

      final result = await _db
          .collection('Users')
          .doc(userId)
          .collection("Addresses")
          .get();
      return result.docs
          .map((e) => AddressModel.fromDocumentSnapShot(e))
          .toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again later";
    }
  }

  Future<void> updateSelectedAddress(String addressId, bool selected) async {
    try {
      final userId =
          AuthenticationRepository.instance.currentAuthenticatedUser!.uid;
      await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({"SelectedAddress": selected});
    } catch (e) {
      throw "Unable to update selected Address. Please try again later";
    }
  }

  Future<String> addAddress(AddressModel addressModel) async {
    try {
      final userId =
          AuthenticationRepository.instance.currentAuthenticatedUser!.uid;
      final data = await _db
          .collection('Users')
          .doc(userId)
          .collection('Addresses')
          .add(addressModel.toMap());
      return data.id;
    } catch (e) {
      throw "Unable to add address. Please try again later";
    }
  }
}
