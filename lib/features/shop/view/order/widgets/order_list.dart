import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:tstore/features/shop/controller/products/order_controller.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/loaders/anmation_loaders.dart';
import '../../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';

class TOrderListScreen extends StatelessWidget {
  const TOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.getUserOrder(),
      builder: (_, snapshot) {
        final emptyWidget = TAnimationLoaderWidget(
          text: 'Whoops! No Orders Yet',
          animation: TImages.wishListIllustration,
          showAction: true,
          actionText: 'Let\'s add some',
          onActionPressd: () => Get.offAll(() => const NavigationMenu()),
        );
        const loader = VerticalProductShimmer();
        final widget = TCloudHelperFunctions.checkMultiRecordState(
            snapshot: snapshot,  nothingFound: emptyWidget);
        if (widget != null) return widget;

        final orders = snapshot.data!;
        return ListView.separated(
            itemCount: orders.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
            itemBuilder: (context, index) {
              final order = orders[index];
              return TRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(TSizes.md),
                bgColor: THelperFunctions.isDarkMode(context)
                    ? TColors.dark
                    : TColors.light,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Row-1
                    Row(
                      children: [
                        /// Icon
                        const Icon(Iconsax.ship),
                        const SizedBox(
                          width: TSizes.spaceBtwItems / 2,
                        ),

                        /// 2 Status & Date
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.status.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: TColors.primary,
                                    ),
                              ),
                              Text(order.formattedOrderDate,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                            ],
                          ),
                        ),

                        /// Icon
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Iconsax.arrow_right_34,
                              size: TSizes.iconSm,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),

                    /// Row-2
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              /// Icon
                              const Icon(Iconsax.tag),
                              const SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),

                              /// 2 Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              /// Icon
                              const Icon(Iconsax.calendar),
                              const SizedBox(
                                width: TSizes.spaceBtwItems / 2,
                              ),

                              /// 2 Status & Date
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Shipping Date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium),
                                    Text(order.formattedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
