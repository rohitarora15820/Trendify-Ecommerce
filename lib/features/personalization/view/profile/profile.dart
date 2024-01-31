import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/personalization/view/profile/widgets/profile_menu.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/images/t_circular_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const TCircularImage(
                      image: TImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
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
                onPressed: (){},
                value: "Rohit Arora",

              ),TProfileMenu(
                title: "User Name",
                onPressed: (){},
                value: "rohitarora",

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
                onPressed: (){},
                value: "14334",
                icon: Iconsax.copy,

              ),TProfileMenu(
                title: "E-mail",
                onPressed: (){},
                value: "rohitarora15820@gmail.com",

              ),TProfileMenu(
                title: "Phone Number",
                onPressed: (){},
                value: "8295883688",

              ),TProfileMenu(
                title: "Gender",
                onPressed: (){},
                value: "Male",

              ),TProfileMenu(
                title: "Date of Birth",
                onPressed: (){},
                value: "08 Oct, 1996",

              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  child: const Text("Close Account",style: TextStyle(color: Colors.red),),
                  onPressed: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

