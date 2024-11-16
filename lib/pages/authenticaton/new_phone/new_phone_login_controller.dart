import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone_otp/new_phone_otp_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_options/register_options_page.dart';
import 'package:my_job_flutter/pages/dashboard/dashboard_page.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sisira Sahoo
/// On 16/04/22 6:07 PM
///

class NewLoginPhoneController extends GetxController {
  String _phone = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  bool isLoginFromStart = false;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    Map<String, dynamic> args = Get.arguments ?? {};
    isLoginFromStart = args["isLoginFromStart"] ?? false;
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onPhoneSaved(String? newValue) {
    _phone = newValue!.trim();
  }

  loginPhoneNumber() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      AuthHelper.sendOtpToPhone(_phone).then((value) {
        Get.bottomSheet(
          NewPhoneOtpPage(phone: _phone),
        );
      }).catchError((e, s) {
        log('loginPhoneNumber', error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }

  onSkipForNowPressed() {
    SharedPreferenceHelper.skipLogin();
    Get.offAllNamed(DashboardPage.routeName);
  }
}
