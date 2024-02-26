import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore/features/personalization/view/address/add_new_address.dart';
import 'package:tstore/features/personalization/view/address/widgets/single_address.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/sizes.dart';
import 'package:tstore/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/custom_appbar/appbar.dart';
import '../../../shop/controller/address_controller.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          Get.to(() => const AddNewAddressScreen());
        },
        child: const Icon(
          Iconsax.add,
          color: TColors.white,
        ),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Obx(()=>
             FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                future: controller.getUserAddress(),
                builder: (context, snapshot) {
                  final result = TCloudHelperFunctions.checkMultiRecordState(
                      snapshot: snapshot);
                  if (result != null) return result;
                  final address = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: address.length,
                    itemBuilder: (context, index) => TSingleAddress(
                      address: address[index],
                      onTap: () => controller.newSelectedAddress(address[index]),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
