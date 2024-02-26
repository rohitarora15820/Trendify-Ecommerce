import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/address/address_reposotory.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/helpers/network_manager.dart';
import 'package:tstore/utils/popups/full_screen_loader.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../model/address_model.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  /// Variables
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  /// Fetch User Specific Address
  Future<List<AddressModel>> getUserAddress() async {
    try {
      final result = await addressRepository.getUserAddress();
      selectedAddress.value = result.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return result;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future newSelectedAddress(AddressModel newAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async => false,
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator());
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedAddress(
            selectedAddress.value.id, false);
      }

      // Assign the new address
      newAddress.selectedAddress = true;
      selectedAddress.value = newAddress;

      // set true for new address
      await addressRepository.updateSelectedAddress(
          selectedAddress.value.id, true);
      Get.back();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  // Add New Address
  Future addNewAddress() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Storing address...', TImages.loadingIllustration);

// Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!addressKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Save Address
      final data = AddressModel(
          id: '',
          name: name.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          street: street.text.trim(),
          city: city.text.trim(),
          state: state.text.trim(),
          postalCode: postalCode.text.trim(),
          country: country.text.trim(),
          selectedAddress: true);

      final id = await addressRepository.addAddress(data);

      // Update id
      data.id = id;
      selectedAddress(data);

      // Stop Loading & Show Success message
      TFullScreenLoader.stopLoading();

      TLoaders.sucessSnackBar(
          title: 'Congratulations',
          message: 'Your address has been saved successfully');

      // refresh Data
      refreshData.toggle();

      // reset form
      resetFormFields();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Address Not Found', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressKey.currentState?.reset();
  }
}
