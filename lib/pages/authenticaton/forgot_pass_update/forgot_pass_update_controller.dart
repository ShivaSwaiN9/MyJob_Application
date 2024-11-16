import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/login_phone/login_page.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 18-01-2022 17:38
///

class ForgotPasswordUpdateController extends GetxController {
  String _newPassword = '';
  String _confirmPassword = '';
  bool isActive = true;
  bool isActive1 = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;
  late String userId, accessToken;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      userId = map['userId'];
      accessToken = map['accessToken'];
    }
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onNewPasswordSaved(String? newValue) {
    _newPassword = newValue!.trim();
  }

  String? newPasswordValidator(String? value, BuildContext context) {
    _newPassword = value?.trim() ?? "";
    if (value!.isEmpty) {
      return S.of(context).passwordIsRequired;
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(value)) {
      return S.of(context).lengthShouldBeMoreThan8MustContainDigitSymbols;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? value, BuildContext context) {
    if (value?.trim() != _newPassword) return S.of(context).passwordsDidntMatch;
  }

  void onConfirmPasswordSaved(String? newValue) {
    _confirmPassword = newValue!.trim();
  }

  resetPassWord() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      AuthHelper.resetPassword(_newPassword, userId, accessToken).then((value) {
        Get.offAllNamed(LoginPage.routeName);
      }).catchError((e, s) {
        log('resetPassWord', error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
