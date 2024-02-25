import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/common/widgets/images/t_roundec_images.dart';
import 'package:tstore/common/widgets/products/products_cards/product_card_horizontal.dart';
import 'package:tstore/common/widgets/shimmer/horizontal_product_shimmer.dart';
import 'package:tstore/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:tstore/common/widgets/text/section_heading.dart';
import 'package:tstore/features/shop/controller/category_controller.dart';
import 'package:tstore/features/shop/model/category_model.dart';
import 'package:tstore/features/shop/view/all_products/all_products.dart';
import 'package:tstore/utils/constants/image_strings.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../utils/helpers/cloud_helper_functions.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key, required this.category});


  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());
    return  Scaffold(
      appBar:  TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Banner
            const TRoundedImage(imageUrl: TImages.promoBanner1,
            width: double.infinity,
              height: null,
              applyImageRadius: true,
            ),
            const SizedBox(height: TSizes.spaceBtwSections,),


            /// Sub-Categories
            FutureBuilder(
              future: controller.getSubCategoryProducts(categoryId: category.id),
              builder: (context, snapshot) {
                const loader=HorizontalProductShimmer();

                final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                if(widget != null) return widget;

                final subCategories=snapshot.data!;

                return ListView.builder(
                  itemCount: subCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final subCategory = subCategories[index];
                    return FutureBuilder(
                      future: controller.getCategoryProducts(categoryId: subCategory.id),
                      builder: (context, snapshot) {
                        const loader=HorizontalProductShimmer();

                        final widget=TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot,loader: loader);
                        if(widget != null) return widget;

                        final subCategories=snapshot.data!;

                        return Column(
                          children: [
                            /// Heading
                            TSectionHeading(title: subCategory.name, onPressed: (){
                              Get.to(()=> AllProductsScreen(title: subCategory.name,
                              futureMethod: controller.getCategoryProducts(categoryId: subCategory.id,limit: -1),
                              ));
                            },),
                            const SizedBox(height: TSizes.spaceBtwItems/2,),

                            SizedBox(
                              height: 120,
                              child: ListView.separated(
                                itemCount: subCategories.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems,),
                                itemBuilder: (context, index) =>  TProductCardHorizontal(product: subCategories[index],),

                              ),
                            )
                          ],
                        );
                      }
                    );
                  } ,);

              }
            )
            
          ],
        ),
        ),
      ),
    );
  }
}
