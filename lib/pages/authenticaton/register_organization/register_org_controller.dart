import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/photo_chooser.dart';

class RegisterOrgController extends GetxController {
  String? orgName;
  String? phone;
  String? name;
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isActive = true;
  bool isActive1 = true;
  File? image;
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  final GlobalKey<AppOutlineButtonState> skipButtonKey =
      GlobalKey<AppOutlineButtonState>();
  late Rx<AutovalidateMode> autoValidateMode1;
  late Rx<AutovalidateMode> autoValidateMode2;

  late PageController pageController;
  RxInt currentPage = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      currentPage.value = map["index"] ?? 0;
    }
    // name = SharedPreferenceHelper.user?.user?.name;
    // gender = SharedPreferenceHelper.user?.user?.gender;
    // dob = SharedPreferenceHelper.user?.user?.dob;
    autoValidateMode1 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    autoValidateMode2 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void dispose() {
    autoValidateMode1.close();
    autoValidateMode2.close();
    pageController.dispose();
    super.dispose();
  }

  void onEmailSaved(String? newValue) {
    email = newValue!.trim();
  }

  String? confirmPasswordValidator(String? value, BuildContext context) {
    if (value?.trim() != password) return 'Passwords didn\'t match';
  }

  void onConfirmPasswordSaved(String? newValue) {
    confirmPassword = newValue!.trim();
  }

  void onPasswordSaved(String? newValue) {
    password = newValue!.trim();
  }

  void onOrgNameSaved(String? newValue) {
    orgName = newValue!.trim();
  }

  void onNameSaved(String? newValue) {
    name = newValue!.trim();
  }

  void onPhoneSaved(String? newValue) {
    phone = newValue!.trim();
  }

  void onPageChange(int value) {
    currentPage.value = value;
  }

  Future<bool> wilPopScope() async {
    if (currentPage.value == 0) {
      return true;
    } else {
      pageController.animateToPage(currentPage.value - 1,
          duration: kThemeAnimationDuration, curve: Curves.easeOut);
      return false;
    }
  }

  chooseProfilePicture() async {
    Get.focusScope?.unfocus();
    Get.bottomSheet(const PhotoChooser(), backgroundColor: Colors.white)
        .then((value) {
      if (value != null && value is File) {
        image = value;
        update();
        print("image eithi $image $value");
      }
    });
  }

  completeStep1() {
    final state = formKey1.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode1.value = AutovalidateMode.always;
    } else {
      state.save();
      pageController.animateToPage(currentPage.value + 1,
          duration: kThemeAnimationDuration, curve: Curves.easeIn);
    }
  }

  completeStep2() {
    final state = formKey2.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode2.value = AutovalidateMode.always;
    } else {
      state.save();
      pageController.animateToPage(currentPage.value + 1,
          duration: kThemeAnimationDuration, curve: Curves.easeIn);
    }
  }

  completeStep3() async {
    if (image == null) {
      SnackBarHelper.show(S.current.pleaseSelectYourProfilePicture);
      return;
    }
    buttonKey.currentState?.showLoader();
    try {
      String? url;
      if (image != null) {
        url = await ApiCall.singleFileUpload(image!);
      }
      await AuthHelper.signUpUser({
        "email": email,
        "role": 3,
        "companyName": orgName,
        "name": name,
        "accessToken": SharedPreferenceHelper.user?.accessToken,
        if (url != null) "avatar": url
      });
      AuthHelper.checkUserLevel();
    } catch (e, s) {
      log("completeStep3", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      buttonKey.currentState?.hideLoader();
    }
  }

  skipStep3() async {
    skipButtonKey.currentState?.showLoader();
    try {
      SharedPreferenceHelper.skipAvatar();
      print({'name': orgName});
      if (SharedPreferenceHelper.user?.user == null) {
        await AuthHelper.signUpUser({
          "email": email,
          "password": password,
          "role": 3,
          "companyName": orgName,
          "name": name,
          "accessToken": SharedPreferenceHelper.user?.accessToken
        });
      }
      AuthHelper.checkUserLevel();
    } catch (e, s) {
      log("skipStep3", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      skipButtonKey.currentState?.hideLoader();
    }
  }
}
