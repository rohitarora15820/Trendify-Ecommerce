import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/user/user_repository.dart';
import 'package:tstore/features/personalization/controller/user_controller.dart';


import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../view/profile/profile.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeName();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName!;
    lastName.text = userController.user.value.lastName!;
  }

  Future<void> updateUserName() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          "Updating data...", TImages.loadingIllustration);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Update User First & Last Name in Firestore
      Map<String, dynamic> fullName = {
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim()
      };
      await userRepository.updateSingleField(fullName);

      /// Update Rx Value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Remover Loader
      TFullScreenLoader.stopLoading();

      ///  Show Success Message
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your username has been successfully added to the list of users");

      ///  Move to Verify Email Screen
      Get.to(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      /// Show More Generic Error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
