import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:tstore/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:tstore/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/features/authentication/view/login/login.dart';
import 'package:tstore/features/personalization/view/address/address.dart';
import 'package:tstore/features/shop/controller/category_controller.dart';
import 'package:tstore/features/shop/view/cart/cart.dart';
import 'package:tstore/features/shop/view/order/order.dart';
import 'package:tstore/utils/constants/colors.dart';

import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/dummy/dummy_data.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';

import '../../../../common/widgets/list_tiles/user_profiile_tile.dart';
import '../../../shop/controller/banner_controller.dart';
import '../../../shop/controller/product_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AuthenticationRepository());
    // final categoryController=Get.put(CategoryController());
    // final bannerController=Get.put(BannerController());
    final productController=Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                ///AppBar
                TAppBar(
                    title: Text(
                  'Account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .apply(color: TColors.white),
                )),

                /// User Profile Card
                const TUserProfileTile(),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),

            ///Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///Account Settings
                  const TSectionHeading(
                    title: "AccountSettings",
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Address",
                    subtitle: "Set shopping delivery address",
                    onTap: () {
                      Get.to(()=>const UserAddressScreen());
                    },
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subtitle: "Add, remove products and move to checkout",
                    onTap: () {
                      Get.to(()=> const CartPage());
                    },
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subtitle: "In-progress and Completed Orders",
                    onTap: () {
                      Get.to(()=> const OrderScreen());
                    },
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subtitle: "Withdraw balance to registered bank account",
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subtitle: "List of all the discounted coupons",
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Set any kind of notification message",
                    onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subtitle: "Manage data usage and Connected accounts",
                    onTap: () {},
                  ),

                  ///AppSettings
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(
                    title: "App Settings",
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subtitle: "Upload Data to your Cloud FireStore",
                    onTap: () {
                      // categoryController.uploadCategoryData(TDummyData.categories);
                      productController.uploadProductData(TDummyData.products);
                    },
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "GeoLocation",
                    subtitle: "Set recommendation based on location",
                    onTap: () {},
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subtitle: "Search result is safe for all ages",
                    onTap: () {},
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subtitle: "Set image quality to be seen",
                    onTap: () {},
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),

                  /// Logout Button
                  const SizedBox(height: TSizes.spaceBtwSections,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: ()=>controller.logout(),
                    child:const Text("Logout"),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2.5,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
