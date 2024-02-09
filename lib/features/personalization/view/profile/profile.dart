import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/personalization/controller/user_controller.dart';
import 'package:tstore/features/personalization/view/profile/widgets/change_name.dart';
import 'package:tstore/features/personalization/view/profile/widgets/profile_menu.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/images/t_circular_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const TAppBar(
          showBackArrow: true,
          title: Text(
            "Profile",
          )),

      ///body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final networkImage = controller.user.value.profilePicture;
                      final image =
                          networkImage.isNotEmpty ? networkImage : TImages.user;
                      return
                        controller.imageUploading.value?
                            TShimmerLoader(width: 80, height: 80, radius: 80,)
                            :
                        TCircularImage(
                        image: image,
                        width: 80,
                        height: 80,
                        isNetworkImage: networkImage.isNotEmpty,
                      );
                    }),
                    TextButton(
                        onPressed: () {
                          controller.uploadUserProfilePicture();
                        },
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),

              ///Details
              const SizedBox(
                height: TSizes.spaceBtwSections / 2,
              ),

              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              /// Heading Profile Info
              const TSectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TProfileMenu(
                title: "Name",
                onPressed: () {
                  Get.to(() => ChangeName());
                },
                value: controller.user.value.fullName,
              ),
              TProfileMenu(
                title: "User Name",
                onPressed: () {},
                value: controller.user.value.username,
              ),

              const TSectionHeading(
                title: "Personal Information",
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              TProfileMenu(
                title: "User ID",
                onPressed: () {},
                value: controller.user.value.id,
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                title: "E-mail",
                onPressed: () {},
                value: controller.user.value.email,
              ),
              TProfileMenu(
                title: "Phone Number",
                onPressed: () {},
                value: controller.user.value.phoneNumber,
              ),
              TProfileMenu(
                title: "Gender",
                onPressed: () {},
                value: "Male",
              ),
              TProfileMenu(
                title: "Date of Birth",
                onPressed: () {},
                value: "08 Oct, 1996",
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  child: const Text(
                    "Close Account",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    controller.deleteAccountWarningPopup();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
