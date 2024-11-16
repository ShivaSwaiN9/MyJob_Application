import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_update/forgot_pass_update.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 24-07-2021 17:37
///

class ForgotOtpController extends GetxController {
  String pin = "";
  RxBool isResendActive = RxBool(false);
  late Timer _timer;
  RxInt timerCounter = RxInt(59);
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late String email;
  late TextEditingController? textController;

  // bool _isFromOnBoarding = false;

  String get timerText =>
      '00:${timerCounter < 10 ? timerCounter.toString().padLeft(2, '0') : timerCounter}';

  void onCodeUpdated(String code) {
    textController?.text = code;
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    SmsAutoFill().getAppSignature.then((value) {
      log("APP SIGNATURE $value");
    });
    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      email = map['email'];
      //_isFromOnBoarding = map['isFromOnBoarding'] ?? false;
    }
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
    AuthHelper.sendEmailOtp(email).then((value) {
      buttonKey.currentState?.hideLoader();
      startTimer();
    }).catchError((err) {
      buttonKey.currentState?.hideLoader();
      SnackBarHelper.show(err.toString());
    });
  }

  void resetUsingOtp(BuildContext context) {
    if (pin.isEmpty) {
      SnackBarHelper.show(S.of(context).pleaseEnterPinToContinue);
    } else {
      _reset(context);
    }
  }

  void _reset(BuildContext context) {
    Get.focusScope!.unfocus();
    if (pin.isEmpty || pin.length != 6) {
      SnackBarHelper.show(S.of(context).pleaseEnterPinToContinue);
    } else {
      buttonKey.currentState?.showLoader();
      AuthHelper.verifyForgotPasswordOtp(email, pin).then((value) {
        Get.toNamed(ForgotPasswordUpdatePage.routeName, arguments: {
          'userId': value['userId'],
          'accessToken': value['accessToken']
        });
      }).catchError((e, s) {
        log("loginPhoneNumber", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  void onChanged(String value) {
    pin = value.trim();
  }

  void onCompleted(String value, BuildContext context) {
    pin = value.trim();
    _reset(context);
  }
}
