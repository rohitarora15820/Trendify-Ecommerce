import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/sucess_screen/sucess_screen.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/data/repositories/order/order_repository.dart';
import 'package:tstore/data/services/firebase_notification_service.dart';
import 'package:tstore/features/authentication/model/user_model.dart';
import 'package:tstore/features/shop/controller/checkout/checkout_controller.dart';
import 'package:tstore/features/shop/controller/products/cart_controller.dart';
import 'package:tstore/navigation_menu.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/popups/full_screen_loader.dart';
import 'package:tstore/utils/popups/loader.dart';

import '../../../../common/widgets/loaders/anmation_loaders.dart';
import '../../../../utils/constants/enums.dart';
import '../../../personalization/controller/user_controller.dart';
import '../../model/order_model.dart';
import '../address_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  /// Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());
  final firebaseRepository = Get.put(FirebaseNotificationsController());
  final razorPaymentController = Razorpay();
  final userController = UserController.instance;

  @override
  void onInit() {
    super.onInit();
    razorPaymentController.on(
        Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPaymentController.on(
        Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPaymentController.on(
        Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response)async {
    // Do something when payment succeeds
    TLoaders.sucessSnackBar(
        title: "Payment Success", message: response.paymentId);
    await firebaseRepository.sendNotification('Order Placed', userController.user.value.userToken, "Order Created Suceesfully");

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    TLoaders.errorSnackBar(title: "Error Occured", message: response.message);
    Get.offAll(()=> NavigationMenu());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    TLoaders.sucessSnackBar(title: "Payment Wallet", message: response.walletName);
  }

  Future<dynamic> openRazorPaySdk(double amount, OrderModel order) async {

    var options = {
      'key': 'rzp_test_cwBUehfXB9t2Gx',
      'amount': (amount * 100).round(),
      'name': order.items.first.title,
      'description': order.items.first.brandName,
      'prefill': {
        'contact': AuthenticationRepository
            .instance.currentAuthenticatedUser!.phoneNumber,
        'email':
            AuthenticationRepository.instance.currentAuthenticatedUser!.email
      },
      'external': {
        'wallets' : ['paytm'],
      }
    };
    log(options.toString());
    try {
      razorPaymentController.open(options);
    } catch (e) {
      TLoaders.errorSnackBar(
          title: "Unable to open the SDK", message: "Please Try again Later");
    }
  }

  clearRazorPay() {
    razorPaymentController.clear();
  }

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

      await openRazorPaySdk(totalAmount, order);


      await orderRepository.saveUserOrder(order, userId);


      cartController.clearCart();

      Get.off(() => SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: "Payment Success!",
          subtitle: "Your item will be shipped soon!",
          onPressed: () => Get.offAll(() => const NavigationMenu()))

      );

    } catch (e) {
      TLoaders.warningSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
