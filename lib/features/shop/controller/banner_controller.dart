import 'package:get/get.dart';
import 'package:tstore/data/repositories/banners/banners_repository.dart';

import '../../../utils/popups/loader.dart';
import '../model/banner_model.dart';

class BannerController extends GetxController{

  // Variables
  final carousalCurrentIndex = 0.obs;
  final bannerLoading = false.obs;
  final bannerUploadLoading = false.obs;
  final RxList<BannerModel> bannerList =  <BannerModel>[].obs;
  final bannerRepository=Get.put(BannerRepository());


  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  } // Update Page Dot Navigator
  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }

  // Load Banner Data
  Future<void> fetchBanners() async {
    try {
      // show loader
      bannerLoading.value = true;

      // fetch categories
      final banners = await bannerRepository.fetchBanners();

      // update list
      bannerList.assignAll(banners);




    } catch (e) {

      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      bannerLoading.value=false;
    }
  }


  Future<void> uploadBannersData(List<BannerModel> banners)async{
    try{
      bannerUploadLoading.value=true;
      await bannerRepository.uploadDummyData(banners);
      TLoaders.sucessSnackBar(
          title: "Congratulations",
          message: "Your Banners Data has been updated successfully!");
    }catch (e) {

      TLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      bannerUploadLoading.value=false;
    }

  }
}