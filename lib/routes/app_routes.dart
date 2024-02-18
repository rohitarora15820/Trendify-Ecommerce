import 'package:get/get.dart';
import 'package:tstore/features/authentication/view/login/login.dart';
import 'package:tstore/features/authentication/view/onboarding/onboarding.dart';
import 'package:tstore/features/authentication/view/password_configuration/forgot_password.dart';
import 'package:tstore/features/authentication/view/signup/signup.dart';
import 'package:tstore/features/authentication/view/signup/verify_email.dart';
import 'package:tstore/features/personalization/view/address/address.dart';
import 'package:tstore/features/personalization/view/profile/profile.dart';
import 'package:tstore/features/personalization/view/setting/setting.dart';
import 'package:tstore/features/shop/view/cart/cart.dart';
import 'package:tstore/features/shop/view/checkout/checkout.dart';
import 'package:tstore/features/shop/view/home/home.dart';
import 'package:tstore/features/shop/view/order/order.dart';
import 'package:tstore/features/shop/view/shop/shop.dart';
import 'package:tstore/features/shop/view/wishlist/wishlist.dart';
import 'package:tstore/routes/routes.dart';

import '../features/shop/view/product_review/product_review.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.home, page: () => const HomeScreen()),
    GetPage(name: TRoutes.store, page: () => const Shop()),
    GetPage(name: TRoutes.favourites, page: () => const FavouriteScreen()),
    GetPage(name: TRoutes.settings, page: () => const SettingPage()),
    GetPage(name: TRoutes.productReviews, page: () => const ProductReviewScreen()),
    GetPage(name: TRoutes.order, page: () => const OrderScreen()),
    GetPage(name: TRoutes.checkout, page: () => const CheckoutPage()),
    GetPage(name: TRoutes.cart, page: () => const CartPage()),
    GetPage(name: TRoutes.userProfile, page: () => const ProfileScreen()),
    GetPage(name: TRoutes.userAddress, page: () => const UserAddressScreen()),
    GetPage(name: TRoutes.signup, page: () => const SignUp()),
    // GetPage(name: TRoutes.verifyEmail, page: () => const VerifyEmailScreen(email: email)),
    GetPage(name: TRoutes.signIn, page: () => const LoginScreen()),
    GetPage(name: TRoutes.forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => const OnBoardingScreen()),
  ];
}
