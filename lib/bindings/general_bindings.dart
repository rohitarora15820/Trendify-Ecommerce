import 'package:get/get.dart';
import 'package:tstore/data/services/firebase_notification_service.dart';
import 'package:tstore/features/shop/controller/address_controller.dart';
import 'package:tstore/features/shop/controller/checkout/checkout_controller.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/features/shop/controller/products/order_controller.dart';
import 'package:tstore/features/shop/controller/variation_controller.dart';
import 'package:tstore/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckoutController());
    Get.put(FirebaseNotificationsController());

  }


}