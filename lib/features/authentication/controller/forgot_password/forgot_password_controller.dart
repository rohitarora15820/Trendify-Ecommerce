import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/features/authentication/view/password_configuration/reset_password.dart';
import 'package:tstore/utils/constants/image_strings.dart';

import 'package:tstore/utils/popups/loader.dart';

import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance=> Get.find();


  /// Variables
final email =TextEditingController();
GlobalKey<FormState> forgotPasswordFormKey=GlobalKey<FormState>();


/// Send Resend Password Email
sendPasswordResetEmail()async{
  try{
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
    if (!forgotPasswordFormKey.currentState!.validate()) {
      TFullScreenLoader.stopLoading();
      return;
    }

    await AuthenticationRepository.instance.sendForgotPasswordEmail(email.text.trim());

    ///  Show Success Message
    TLoaders.sucessSnackBar(
        title: "Email Sent",
        message: "Email Link Sent to Reset your password".tr);
    TFullScreenLoader.stopLoading();

    ///  Move to Verify Email Screen
    Get.to(() =>  ResetPassword(
      email: email.text.trim(),
    ));
  }catch(e){
    TFullScreenLoader.stopLoading();

    /// Show More Generic Error
    TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
  }
}

resendPasswordResetEmail(String email)async{
  try{
    /// Start Loading
    TFullScreenLoader.openLoadingDialog(
        "We are processing your information...", TImages.loadingIllustration);

    /// Check Internet Connectivity
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      TFullScreenLoader.stopLoading();
      return;
    }



    await AuthenticationRepository.instance.sendForgotPasswordEmail(email);

    ///  Show Success Message
    TLoaders.sucessSnackBar(
        title: "Email Sent",
        message: "Email Link Sent to Reset your password".tr);
    TFullScreenLoader.stopLoading();

    ///  Move to Verify Email Screen
    Get.to(() =>  ResetPassword(
      email: email,
    ));


  }catch(e){
    TFullScreenLoader.stopLoading();

    /// Show More Generic Error
    TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
  }
}

}