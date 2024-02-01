import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tstore/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tstore/data/repositories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async{
  ///  Add Widget Binding
  final widgetBinding=WidgetsFlutterBinding.ensureInitialized();

  /// Init Local Storage
 await GetStorage.init();

  /// Await Native Splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);



  /// Initial Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  runApp(const App());
}