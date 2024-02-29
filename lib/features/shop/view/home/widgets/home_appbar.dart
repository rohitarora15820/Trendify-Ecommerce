import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/personalization/controller/user_controller.dart';

import '../../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../../../common/widgets/loaders/shimmer_loader.dart';
import '../../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(TTexts.homeAppbarTitle,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: TColors.grey)),
          Obx(() {
            if (controller.profileLoading.value) {
              return TShimmerLoader(
                width: 80,
                height: 15,
              );
            } else {
              return Text(controller.user.value.fullName,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(color: TColors.white));
            }
          })
        ],
      ),
      actions: [
        TCartCounterIcon(

          iconColor: TColors.white,

        )
      ],
    );
  }
}
