import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tstore/data/repositories/user/user_repository.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../authentication/model/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository=Get.put(UserRepository());

  // Save User Record from any Registered provider
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts =
            UserModel.nameParts(userCredential.user!.displayName ?? "");
        final userName =
            UserModel.generateUserName(userCredential.user!.displayName ?? '');

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
    } catch (e) {
      TLoaders.warningSnackBar(
          title: "Data not saved",
          message:
              "Something went wrong while saving your information.You can re-save your data in your Profile");
    }
  }
}
