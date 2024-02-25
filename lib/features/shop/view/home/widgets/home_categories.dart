import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/controller/category_controller.dart';
import 'package:tstore/features/shop/view/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../common/widgets/shimmer/category_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.categoryLoading.value) {
        return const TCategoryShimmer();
      }
      if (categoryController.featuredCategoryList.isEmpty) {
        return Center(
          child: Text(
            "No Data Found!",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategoryList[index];

            return TVerticalImageText(
              isNetworkImage: true,


              title: category.name,
              image: category.image,
              onPressed: () {
                Get.to(() =>  SubCategoryScreen(category:category));
              },
            );
          },
        ),
      );
    });
  }
}
