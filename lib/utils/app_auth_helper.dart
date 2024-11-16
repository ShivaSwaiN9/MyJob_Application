import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_options/register_options_page.dart';
import 'package:my_job_flutter/pages/dashboard/dashboard_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/language_choose_page/lanuage_choose_page.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'snackbar_helper.dart';
import 'package:device_info_plus/device_info_plus.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  static Future<dynamic> loginEmail(String email, pass) async {
    String? fcmId;
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(alert: true);
      if (settings.alert == AppleNotificationSetting.enabled) {
        fcmId = await FirebaseMessaging.instance.getToken();
      }
    } else {
      fcmId = await FirebaseMessaging.instance.getToken();
    }
    final result = await ApiCall.post("authentication", body: {
      "email": email,
      "password": pass,
      "strategy": "local",
      if (fcmId != null) "fcmId": fcmId
    });
    log('login result : - $result');
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    SnackBarHelper.show("Login Successful");

    final userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user.user);
    return result.data;
  }

  static Future<dynamic> sendEmailOtp(String email) async {
    await ApiCall.post(
      'v1/forgot-password',
      body: {"email": email},
      isAuthNeeded: false,
    );
    SnackBarHelper.show("OTP sent successfully to your email");
  }

  static Future<dynamic> verifyForgotPasswordOtp(
      String email, String otp) async {
    final result = await ApiCall.patch(
      'v1/forgot-password',
      body: {'email': email, 'otp': otp},
      isAuthNeeded: false,
    );

    return result.data;
  }

  static Future<dynamic> sendOtpToPhone(String? phone,
      {String action = 'authentication', bool isAuthNeeded = false}) async {
    final result = await ApiCall.post(ApiRoutes.authenticatePhone,
        body: {"action": action, "phone": phone}, isAuthNeeded: isAuthNeeded);
    log('OTP res ${result.data}');
    SnackBarHelper.show("OTP sent successfully to $phone");
    return result.data;
  }

  static Future<UserResponse> verifyLoginPhoneOtp(
      String phone, String otp) async {
    // final fcmId = await FirebaseMessaging.instance.getToken();
    // final Position latLng = await CheckPermissions.getCurrentLocation();

    final deviceInfo = await getDeviceDetails();
    final fcmId = await FirebaseMessaging.instance.getToken();

    final result = await ApiCall.patch(ApiRoutes.authenticatePhone,
        body: {
          "phone": phone,
          "otp": otp,
          "action": "authentication",
          "fcmId": fcmId,
          "deviceId": deviceInfo['deviceId'],
          // "deviceType": deviceInfo['deviceType'],
          // "deviceName": deviceInfo['deviceName'],
          // "coordinates": [latLng.longitude, latLng.latitude],
        },
        isAuthNeeded: false);
    log("RESULT ${result.statusCode} ${result.data}");

    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    return user;
  }

  static Future<dynamic> resetPassword(
      String password, String userId, String accessToken) async {
    final result = await ApiCall.patch(
      "v1/user",
      id: userId,
      extraOptions: Options(headers: {"Authorization": accessToken}),
      body: {"password": password},
    );
    SnackBarHelper.show("Password successfully changed");
    return result.data;
  }

  static Future<UserResponse> signUpUser(Map<String, dynamic> body) async {
    print(
        "SharedPreferrenceobject2${SharedPreferenceHelper.user?.accessToken}");
    String? fcmId;
    if (Platform.isIOS) {
      final NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(alert: true);
      if (settings.alert == AppleNotificationSetting.enabled) {
        fcmId = await FirebaseMessaging.instance.getToken();
      }
    } else {
      fcmId = await FirebaseMessaging.instance.getToken();
    }
    final result = await ApiCall.post(
      ApiRoutes.user,
      isAuthNeeded: false,
      body: {...body, if (fcmId != null) "fcmId": fcmId},
    );
    print("auth result ${result.data}");
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    final userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user.user);
    return user;
  }

  // static Future<dynamic> userRegisterWithEmail(String email, password) async {
  //   final fcmId = await FirebaseMessaging.instance.getToken();
  //   final result = await ApiCall.post(
  //     "ApiRoutes.user",
  //     body: {"email": email, "password": password},
  //     isAuthNeeded: false,
  //   );
  //   SharedPreferenceHelper.storeUser(user: UserResponse.fromJson(result.data));
  //   return result.data;
  // }

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel() async {
    if (SharedPreferenceHelper.locale == null) {
      Get.offAllNamed(LanguageChoosePage.routeName);
      return;
    } else {
      print("UPDATE ${SharedPreferenceHelper.locale}");
      S.load(Locale(SharedPreferenceHelper.locale!));
    }
    final UserResponse? user = SharedPreferenceHelper.user;
    print("user object ${user?.user?.role}");
    final userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    if (user != null) {
      if (user.user == null) {
        Get.offAllNamed(RegisterOptionsPage.routeName);
      } else {
        userController.updateUser(user.user);
        if (user.user?.role == 1) {
          Get.offAllNamed(DashboardPage.routeName);
        } else if (user.user?.role == 3) {
          SharedPreferenceHelper.isSkipSub
              ? Get.offAllNamed(DashboardForOrgPage.routeName)
              : Get.offAllNamed(SubscriptionOrgPage.routeName,
                  arguments: {"isSignup": true});
        } else {
          SnackBarHelper.show("You are not a user or an organization.");
        }
      }
    } else if (SharedPreferenceHelper.isSkipLogin) {
      Get.offAllNamed(DashboardPage.routeName);
    } else {
      Get.offAllNamed(NewPhonePage.routeName);
    }
  }

  static Future<String?> logoutUser() async {
    SharedPreferenceHelper.logout();
    Get.offAllNamed(NewPhonePage.routeName);
    if (Get.isRegistered<UserController>()) {
      Get.find<UserController>().logOutUser();
    }
  }

  static Future<UserData> updateUser(Map<String, dynamic> body) async {
    final result = await ApiCall.patch("v1/user",
        body: body, id: SharedPreferenceHelper.user!.user!.id!);
    final user = UserData.fromJson(result.data);
    final u = SharedPreferenceHelper.user;
    u?.user = user;
    SharedPreferenceHelper.storeUser(user: u);

    final userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user);
    return user;
  }

 static Future<Map<String, dynamic>> getDeviceDetails() async {
  String? deviceName;
  String? identifier;
  int? deviceType;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  
  try {
    if (Platform.isAndroid) {
      deviceType = 1;
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceName = androidInfo.model;
      identifier = androidInfo.id; // Unique ID for Android
    } else if (Platform.isIOS) {
      deviceType = 2;
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceName = iosInfo.name;
      identifier = iosInfo.identifierForVendor; // Unique ID for iOS
    }
  } on PlatformException {
    throw 'Failed to get platform version';
  }

  return {
    "deviceId": identifier,
    "deviceName": deviceName,
    "deviceType": deviceType,
  };
}
  static Future<String?> refreshAccessToken() async {
    try {
      if (SharedPreferenceHelper.user == null) return null;
      final String? oldToken = SharedPreferenceHelper.user?.accessToken;
      if (oldToken?.isEmpty ?? true) return null;
      Map<String, dynamic> _body = {
        'accessToken': oldToken,
        "strategy": "jwt",
      };
      final result = await ApiCall.post(ApiRoutes.authenticateJwt,
          body: _body, isAuthNeeded: false);
      final String accessToken = result.data['accessToken'];
      final user = UserResponse.fromJson(result.data);
      SharedPreferenceHelper.storeUser(user: user);
      final userController = Get.isRegistered()
          ? Get.find<UserController>()
          : Get.put<UserController>(UserController(), permanent: true);
      userController.updateUser(user.user);
      return accessToken;
    } catch (e, s) {
      log("error", error: e, stackTrace: s);
    }
  }
}
