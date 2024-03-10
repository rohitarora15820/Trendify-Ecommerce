import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tstore/data/services/firebase_notification_service.dart';
import 'package:tstore/features/shop/view/product_detail/product_detail.dart';

import '../model/product_model.dart';
import '../view/cart/cart.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();
    FirebaseNotificationsController.instance.onInit();
  }

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}
