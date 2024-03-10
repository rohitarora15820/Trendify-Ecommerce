import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';

class FirebaseNotificationsController extends GetxController {
  static FirebaseNotificationsController get instance => Get.find();

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log("token"+token.toString());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationRepository.instance.currentAuthenticatedUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  @override // FirebaseMessaging.instance
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {});
    storeNotificationToken();
  }
}
