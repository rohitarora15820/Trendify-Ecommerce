import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class FirebaseDynamicLinkController extends GetxController{
  static FirebaseDynamicLinkController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    initializeDynamicLink();
  }

// initialize the dynamic link
  Future initializeDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final Uri? deeplink = event.link;
      if (deeplink != null) {
        // do handling here
        log(deeplink.toString());
        handleLink(deeplink);
      }
    }).onError((handleError) {
      log("error occurred $handleError");
    });
  }

  handleLink(Uri url){
    List<String> seperatedLink=[];
    seperatedLink.addAll(url.path.split('/'));

    print("seperated link is ${seperatedLink[1]}");

  }

  buildDynamicLink(String title,String image,String productId)async{
    // Prefix Url
    String url="https://trendifyproduct.page.link";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: url,
        link: Uri.parse('$url/$productId'),
        androidParameters:const AndroidParameters(
            packageName: 'com.trendify.ecommerce.app',
            minimumVersion: 0
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            imageUrl: Uri.parse(image),
            title: title,
            description: ''
        )

    );

    final ShortDynamicLink shortLink =
    await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    String? desc=shortLink.shortUrl.toString();

    await Share.share(desc,subject: title);

  }


}