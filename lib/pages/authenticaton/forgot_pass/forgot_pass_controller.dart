import 'package:flutter/material.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_otp/forgot_pass_otp_page.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class ForgotPassController extends GetxController {
  String? _email;

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
    _email = newValue!.trim();
  }

  void forgotEmail() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();

      AuthHelper.sendEmailOtp(_email!).then((value) {
        // print('otp value ${value['otp']}');
        Get.toNamed(ForgotPassOtpPage.routeName, arguments: {
          'email': _email,
        });
      }).catchError((e, s) {
        SnackBarHelper.show(e.toString());
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
