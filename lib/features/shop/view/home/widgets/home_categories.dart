
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/features/shop/view/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text_widget/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return  TVerticalImageText(
            title: "Shoes",
            image: TImages.shoeIcon,
            onPressed: (){
              Get.to(()=> const SubCategoryScreen());
            },
          );
        },
      ),
    );
  }
}