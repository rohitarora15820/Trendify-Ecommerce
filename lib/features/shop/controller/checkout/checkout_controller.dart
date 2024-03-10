import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/list_tiles/payment_tile.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/text/section_heading.dart';
import '../../model/payment_method_model.dart';

class CheckoutController extends GetxController {
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod =
      PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value =
        PaymentMethodModel(name: 'Razorpay', image: TImages.razorpay);
    super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(TSizes.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TSectionHeading(
                  title: 'Select Payment Method',
                  showActionButton: false,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Razorpay', image: TImages.razorpay)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Google Pay', image: TImages.googlePay)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Apple Pay', image: TImages.applePay)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model:
                        PaymentMethodModel(name: 'VISA', image: TImages.visa)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Master Card', image: TImages.masterCard)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Paytm', image: TImages.paytm)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Paystack', image: TImages.paystack)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),
                TPaymentTile(
                    model: PaymentMethodModel(
                        name: 'Credit Card', image: TImages.creditCard)),
                const SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
