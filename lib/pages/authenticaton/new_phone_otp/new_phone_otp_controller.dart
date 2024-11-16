///
/// Created by Sisira Sahoo
/// On 16/04/22 6:20 PM
///

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/register_options/register_options_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_details_controller.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

import 'package:sms_autofill/sms_autofill.dart';

import '../../dashboard_for_org/controller/active_widget_controller.dart';

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 17-07-2021 17:01
///

class LoginPhoneOtpController extends GetxController {
  String pin = "";
  RxBool isResendActive = RxBool(false);
  late Timer _timer;
  RxInt timerCounter = RxInt(59);
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  String? phone;
  late TextEditingController? textController;

  LoginPhoneOtpController(this.phone); // bool _isFromOnBoarding = false;

  String get timerText =>
      '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}';

  void onCodeUpdated(String code) {
    textController?.text = code;
  }

  final loginController = Get.isRegistered<NewLoginPhoneController>()
      ? Get.find<NewLoginPhoneController>()
      : Get.put(NewLoginPhoneController());

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    SmsAutoFill().getAppSignature.then((value) {
      log("APP SIGNATURE $value");
    });

    //   //_isFromOnBoarding = map['isFromOnBoarding'] ?? false;
    // }
    _listenOtp();
    startTimer();
    // Future.delayed(const Duration(minutes: 1), () {
    //   isResendActive = true;
    // });
  }

  @override
  void dispose() {
    _timer.cancel();
    timerCounter.close();
    isResendActive.close();
    textController?.dispose();
    textController = null;
    super.dispose();
  }

  Future<void> _listenOtp() async {
    await SmsAutoFill().listenForCode;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        isResendActive.value = timerCounter < 15;

        if (timerCounter.value < 1) {
          timer.cancel();
        } else {
          timerCounter.value -= 1;
        }
      },
    );
  }

  regenerateOTP() {
    _timer.cancel();
    isResendActive.value = false;
    timerCounter.value = 59;
    buttonKey.currentState?.showLoader();
    AuthHelper.sendOtpToPhone(phone).then((value) {
      buttonKey.currentState?.hideLoader();
      startTimer();
    }).catchError((err) {
      buttonKey.currentState?.hideLoader();
      SnackBarHelper.show(err.toString());
    });
  }

  void loginUsingOtp() {
    if (pin.isEmpty) {
      SnackBarHelper.show(S.current.pleaseEnterPinToContinue);
    } else {
      _login();
    }
  }

  void _login() {
    Get.focusScope!.unfocus();
    if (pin.isEmpty || pin.length != 6) {
      SnackBarHelper.show(S.current.pleaseEnterPinToContinue);
    } else {
      buttonKey.currentState?.showLoader();
      AuthHelper.verifyLoginPhoneOtp(phone!, pin).then((value) {
        if (loginController.isLoginFromStart) {
          AuthHelper.checkUserLevel();
        } else {
          final UserResponse? user = SharedPreferenceHelper.user;
          final userController = Get.isRegistered<UserController>()
              ? Get.find<UserController>()
              : Get.put<UserController>(UserController(), permanent: true);
          if (user != null) {
            if (user.user == null) {
              Get.offAllNamed(RegisterOptionsPage.routeName);
            } else {
              userController.updateUser(user.user);
              Get.back();
              Get.back();
              if (Get.isRegistered<RequestDetailsController>()) {
                Get.find<RequestDetailsController>().getJobDetails();
              }
              if (Get.isRegistered<ActiveControllerJobSeeker>()) {
                Get.find<ActiveControllerJobSeeker>()
                    .getEmployeeRequestActive();
              }
            }
          }
        }
      }).catchError((e, s) {
        log("loginPhoneNumber", error: e, stackTrace: s);
        if (e is IOException || e is PlatformException) {
          SnackBarHelper.show("Some error occurred.");
        } else {
          SnackBarHelper.show(e.toString());
        }
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void onChanged(String value) {
    pin = value.trim();
  }

  void onCompleted(String value) {
    pin = value.trim();
    _login();
  }
}
