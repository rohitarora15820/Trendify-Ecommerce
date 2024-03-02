import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/sucess_screen/sucess_screen.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/data/repositories/order/order_repository.dart';
import 'package:tstore/features/shop/controller/checkout/checkout_controller.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/navigation_menu.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/popups/full_screen_loader.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../../../common/widgets/loaders/anmation_loaders.dart';
import '../../../../utils/constants/enums.dart';
import '../../model/order_model.dart';
import '../address_controller.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

  /// Fetch user order history
  Future<List<OrderModel>> getUserOrder() async {
    try {
      final userOrders = await orderRepository.fetchUserOrders();

      return userOrders;
    } catch (e) {

      TLoaders.warningSnackBar(title: "Oh Snap!", message: e.toString());
      return [];
    }
  }

  /// Add methods for processing
  void processOrders(double totalAmount) async {
    try {
      TFullScreenLoader.openLoadingDialog(
          'Processing your order', TImages.wishListIllustration);

      // Get user authentication id
      final userId =
          AuthenticationRepository.instance.currentAuthenticatedUser!.uid;
      if (userId.isEmpty) return;

      // Add Details
      final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          items: cartController.cartItems.toList());

      await orderRepository.saveUserOrder(order, userId);

      cartController.clearCart();
      // Get.off(()=> TAnimationLoaderWidget(
      //   text: "Payment Success!",
      //   animation: TImages.orderIllustration,
      //   showAction: true,
      //   actionText: "Your item will be shipped soon!",
      //   onActionPressd: () => Get.offAll(() => NavigationMenu()),
      // ));

      Get.off(() => SuccessScreen(

          image: TImages.successfulPaymentIcon,
          title: "Payment Success!",
          subtitle: "Your item will be shipped soon!",
          onPressed: () => Get.offAll(() => const NavigationMenu())));
    } catch (e) {
      TLoaders.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
