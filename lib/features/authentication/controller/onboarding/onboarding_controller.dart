import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tstore/features/authentication/view/login/login.dart';

class onBoardingController extends GetxController {
  static onBoardingController get instance => Get.find();

  //:ToDO Variables
  final pagecontroller = PageController();
  Rx<int> currentPageIndex = 0.obs;

//:ToDO Update Current Index When Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

//:ToDo JUmp to Specific Dot Selected Page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pagecontroller.jumpTo(index);
  }

//:ToDo Update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(()=>const LoginScreen());
    } else {
      pagecontroller.jumpToPage(currentPageIndex.value + 1);
    }
  }

//:ToDo Update current index & jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pagecontroller.jumpToPage(2);
  }
}
