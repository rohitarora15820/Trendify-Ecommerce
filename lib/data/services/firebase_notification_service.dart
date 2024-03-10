import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'package:tstore/data/services/local_notification.dart';
import 'package:http/http.dart' as http;

class FirebaseNotificationsController extends GetxController {
  static FirebaseNotificationsController get instance => Get.find();

  storeNotificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    log("token" + token.toString());
    FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationRepository.instance.currentAuthenticatedUser!.uid)
        .set({'token': token}, SetOptions(merge: true));
  }

  sendNotification(String title, String token, String subtitle) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAU5yJVgw:APA91bHfdWkgsveS6iIvHcy2iNtR6wV4o3HX2oUAlacPxT6wTNwzGUo6OGJqod1PNdgdqgamyaa7UYoBHXnix9xxiDVKd-42fzmkIrIJhYmu6BY0RpEdkhykxFBojRy2zr-XeH8J09kG'
              },
              body: jsonEncode(<String, dynamic>{
                'notification': <String, dynamic>{
                  'title': title,
                  'body': subtitle
                },
                'priority': 'high',
                'data': data,
                'to': token
              }));

      if (response.statusCode == 200) {
        print("Yeh notification is sent");
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  @override // FirebaseMessaging.instance
  void onInit() {
    super.onInit();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.display(event);
    });
    storeNotificationToken();
  }
}
