import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:tstore/common/widgets/custom_appbar/appbar.dart';
import 'package:tstore/utils/constants/sizes.dart';

import '../../../../common/widgets/products/sortable/sortable_products.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../controller/products/all_product_controller.dart';
import '../../model/product_model.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen(
      {super.key, required this.title, this.query, this.futureMethod});

  final String title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllPProductController());
    return Scaffold(
      appBar: TAppBar(
        title: Text(
          title,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: FutureBuilder(
              future: futureMethod ?? controller.fetchProductByQuery(query),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return VerticalProductShimmer();
                }

                if (!snapshot.hasData && snapshot.data == null) {
                  return Center(
                    child: Text("No data available"),
                  );
                }

                if(snapshot.hasError){
                  return Center(
                    child: Text("An error occurred"),
                  );
                }

                final products=snapshot.data!;
                return TSortableProducts(
                  products: products,
                );
              }),
        ),
      ),
    );
  }
}
