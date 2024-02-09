import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/data/repositories/user/user_repository.dart';
import 'package:tstore/features/authentication/view/login/login.dart';
import 'package:tstore/features/personalization/view/profile/widgets/re_auth_login_user_form.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/popups/loader.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/constants/image_strings.dart';

import '../../../utils/helpers/network_manager.dart';
import '../../authentication/model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  final imageUploading = false.obs;
  final hidePassword = true.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  Rx<UserModel> user = UserModel.empty().obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final userData = await userRepository.fetchUserRecord();
      user(userData);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save User Record from any Registered provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // Refresh User Record
      await fetchUserRecord();

      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? "");
          final userName = UserModel.generateUserName(
              userCredential.user!.displayName ?? '');

          /// Map Data
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : "",
              email: userCredential.user!.email ?? "",
              username: userName,
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '');

          // save the user data
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrong while saving your information.You can re-save your data in your Profile");
    }
  }

  /// Delete Account Popup
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: EdgeInsets.all(TSizes.md),
        title: "Delete Account",
        middleText:
            "Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently",
        confirm: ElevatedButton(
            onPressed: () {
              deleteUserAccount();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Text("Delete"),
            )),
        cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: Text("Cancel"),
        ));
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          "Processing...", TImages.loadingIllustration);

      /// Re-Auth User
      final provider = AuthenticationRepository
          .instance.currentAuthenticatedUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        if (provider == "google.com") {
          await AuthenticationRepository.instance.signInWithGoogle();
          await AuthenticationRepository.instance.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => LoginScreen());
        } else if (provider == "password") {
          TFullScreenLoader.stopLoading();
          Get.offAll(() => ReAuthLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();

      /// Show More Generic Error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Re-Authenticate
  reAuthenticateEmailAndPassswordUSer() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          "We are processing your information...", TImages.loadingIllustration);

      /// Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateLoginWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();

      /// Show More Generic Error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Upload User Profile
  uploadUserProfilePicture() async {
    try{
      imageUploading.value =true;
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 512,
          maxWidth: 512,
          imageQuality: 70);
      if (image != null) {
        final imageUrl =
        await userRepository.uploadImage("Users/Images/Profile", image);

        /// update profile oin firestore
        Map<String,dynamic> profileMap={"profilePicture":imageUrl};
        userRepository.updateSingleField(profileMap);

        user.value.profilePicture=imageUrl;
        user.refresh();
        ///  Show Success Message
        TLoaders.sucessSnackBar(
            title: "Congratulations",
            message: "Your profile picture has been updated successfully!");
      }
    }catch(e){
      TFullScreenLoader.stopLoading();

      /// Show More Generic Error
      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally{
      imageUploading.value=false;
    }

  }
}
