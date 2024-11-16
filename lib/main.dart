import 'package:flutter/material.dart';
import 'package:my_job_flutter/app_configs/app_theme.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/splash/splash_screen.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_configs/app_page_routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';

import 'utils/notification_services/in_app_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferenceHelper.preferences = await SharedPreferences.getInstance();
  // SharedPreferenceHelper.clear();
  HttpOverrides.global = new MyHttpOverrides();

  /// Setup for notification services
  InAppNotification.configureInAppNotification();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // initDynamicLinks();
    // InAppNotification.requestPermission();
  }

  // void _goToLink(PendingDynamicLinkData data) {
  //   if (data == null) return;
  //   final Uri deepLink = data.link;
  //   if (deepLink != null) {
  //     switch (deepLink.path) {
  //       case '/profile':
  //         String id = deepLink.queryParameters['id'];
  //         Get.toNamed(OtherProfilePage.routeName, arguments: id);
  //         break;
  //     }
  //   }
  // }
  //
  // Future<void> initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData data) async {
  //         _goToLink(data);
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My job',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      // defaultTransition: Transition.fadeIn,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: SplashPage.routeName,
      getPages: AppPages.pages,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
