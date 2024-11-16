///
/// Created by Sisira Sahoo
/// On 16/04/22 8:58 PM
///

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class NewRegisterDetailsController extends GetxController {
  String? name;
  String? email;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  late Rx<AutovalidateMode> autoValidateMode;

  @override
  void onInit() {
    super.onInit();
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onEmailSaved(String? newValue) {
    email = newValue!.trim();
  }

  void onNameSaved(String? newValue) {
    name = newValue!.trim();
  }

  validateMail(String? email, BuildContext context) {
    if (email == null) return null;
    if (email.trim().isEmpty) {
      return null;
    } else if (!GetUtils.isEmail(email.trim())) {
      return S.of(context).invalidEmailId;
    }
  }

  completeStep() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      try {
        await AuthHelper.signUpUser({
          "email": email,
          "name": name,
          "role": 1,
          "accessToken": SharedPreferenceHelper.user?.accessToken
        });
        AuthHelper.checkUserLevel();
      } catch (e, s) {
        log("completeStep", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      } finally {
        buttonKey.currentState?.hideLoader();
      }
    }
  }
}
