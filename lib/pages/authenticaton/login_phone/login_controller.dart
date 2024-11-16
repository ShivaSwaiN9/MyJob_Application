import 'package:flutter/material.dart';
import 'package:my_job_flutter/pages/dashboard/dashboard_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class LoginPhoneController extends GetxController {
  String? email;
  String? pass;
  bool isActive = true;

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

  void onPassSaved(String? newValue) {
    pass = newValue!.trim();
  }

  void login() {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // Get.toNamed(DashboardPage.routeName);
      buttonKey.currentState?.showLoader();
      AuthHelper.loginEmail(email!, pass!).then((value) {
        print("login pare ${value['user']['role']}");
        if (value['user']['role'] == 1) {
          Get.offNamed(DashboardPage.routeName);
        } else if (value['user']['role'] == 3) {
          Get.offNamed(DashboardForOrgPage.routeName);
        }
      }).catchError((e, s) {
        SnackBarHelper.show(e.toString());
        buttonKey.currentState?.hideLoader();
      }).whenComplete(() => buttonKey.currentState?.hideLoader());
    }
  }
}
