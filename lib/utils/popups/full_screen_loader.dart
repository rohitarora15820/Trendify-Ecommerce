import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../common/widgets/loaders/anmation_loaders.dart';

class TFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          color: THelperFunctions.isDarkMode(Get.context!)
              ? TColors.dark
              : TColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              SizedBox(
                height: 20,
              ),
              TAnimationLoaderWidget(text: text, animation: animation,),
            ],
          ),
        ),
      ),
    );
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
