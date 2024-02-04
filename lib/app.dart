import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tstore/bindings/general_bindings.dart';
import 'package:tstore/features/authentication/view/onboarding/onboarding.dart';
import 'package:tstore/utils/constants/colors.dart';
import 'package:tstore/utils/constants/text_strings.dart';
import 'package:tstore/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,

        /// show Loader meanwhile Authentication Repository is deciding what to open
      home:const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(child: CircularProgressIndicator(color: TColors.white,)),
      )
    );
  }
}
