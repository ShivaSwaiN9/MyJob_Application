import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/job_dm.dart';
import 'package:my_job_flutter/data_models/refer_dm.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class RegisterDetailsController extends GetxController {
  String? name;
  int? gender;
  DateTime? dob;
  String? phone;
  String email = '';
  String password = '';
  int? maritalStatusSelected;
  String? address;
  String? pinCode;
  bool isActive = true;
  String? highestEducation;
  String? course;
  String? university;
  int? yearOfPassing;
  List<JobDatum> jobs = List.empty();
  List<JobDatum> selectedJobs = [];
  JobDatum? selectedJob1;
  JobDatum? selectedJob2;
  String? referralCode;
  String? bio;
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey4 = GlobalKey<FormState>();

  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  final GlobalKey<AppOutlineButtonState> skipButtonKey =
      GlobalKey<AppOutlineButtonState>();
  late Rx<AutovalidateMode> autoValidateMode3;
  late Rx<AutovalidateMode> autoValidateMode1;
  late Rx<AutovalidateMode> autoValidateMode2;
  late Rx<AutovalidateMode> autoValidateMode4;

  late PageController pageController;
  RxInt currentPage = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    final map = Get.arguments as Map<String, dynamic>?;
    if (map != null) {
      currentPage.value = map["index"] ?? 0;
    }
    getAllJob();
    // name = SharedPreferenceHelper.user?.user?.name;
    // gender = SharedPreferenceHelper.user?.user?.gender;
    // dob = SharedPreferenceHelper.user?.user?.dob;
    autoValidateMode3 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    autoValidateMode1 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    autoValidateMode2 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    autoValidateMode4 = Rx<AutovalidateMode>(AutovalidateMode.disabled);
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void dispose() {
    autoValidateMode1.close();
    autoValidateMode2.close();
    autoValidateMode3.close();
    autoValidateMode4.close();
    pageController.dispose();
    super.dispose();
  }

  void onEmailSaved(String? newValue) {
    email = newValue!.trim();
  }

  void onPasswordSaved(String? newValue) {
    password = newValue!.trim();
  }

  void onNameSaved(String? newValue) {
    name = newValue!.trim();
  }

  void onAddressSaved(String? newValue) {
    address = newValue!.trim();
  }

  void onBioSaved(String? newValue) {
    bio = newValue!.trim();
  }

  void onPinCodeSaved(String? newValue) {
    pinCode = newValue!.trim();
  }

  void onPhoneSaved(String? newValue) {
    phone = newValue!.trim();
  }

  void onGenderSaved(int? newValue) {
    gender = newValue;
  }

  void onJobSaved1(JobDatum? newValue) {
    selectedJob1 = newValue!;
    update([0, 1]);
  }

  void onJobSaved2(JobDatum? newValue) {
    selectedJob2 = newValue!;
    update([0, 1]);
  }

  String? dobValidator(DateTime? value, {BuildContext? context}) {
    if (value == null) return '*required';
  }

  String? genderValidator(int? value, {BuildContext? context}) {
    if (value == null) return '*required';
  }

  void onDobSaved(DateTime? newValue) {
    dob = newValue;
  }

  void onHighestEducationSaved(String? newValue) {
    highestEducation = newValue!;
  }

  void onCourseSaved(String? newValue) {
    course = newValue!.trim();
  }

  void onUniversitySaved(String? newValue) {
    university = newValue!.trim();
  }

  void onYearOfPassingSaved(String? newValue) {
    yearOfPassing = int.parse(newValue!);
  }

  void onReferSaved(String? newValue) {
    referralCode = newValue!.trim();
    print(" referralCode $newValue");
  }

  String? yearOfPassingValidator(String? value, {BuildContext? context}) {
    int? x;
    final currentYear = DateTime.now().year;
    if (value == null || value.isEmpty) {
      return '*required';
    } else {
      x = int.parse(value);
      if (x > currentYear) {
        return 'type a valid year';
      }
    }
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

  Future getAllJob() async {
    try {
      final result = await ApiCall.get(ApiRoutes.job);
      jobs = List<JobDatum>.from(
          result.data['data'].map((e) => JobDatum.fromJson(e)));
      update([0]);
    } catch (e, s) {
      log("getAllJob", error: e, stackTrace: s);
    }
  }

  // completeStep() {
  //   final state = formKey.currentState;
  //   if (state == null) return;
  //   if (!state.validate()) {
  //     autoValidateMode.value = AutovalidateMode.always;
  //   } else {
  //     state.save();
  //     Get.focusScope?.unfocus();
  //     Get.toNamed(RegisterDetailsPage.routeName);
  //   }
  // }

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

  skipStep2() {
    pageController.animateToPage(currentPage.value + 1,
        duration: kThemeAnimationDuration, curve: Curves.easeIn);
  }

  completeStep2() {
    final state = formKey2.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode2.value = AutovalidateMode.always;
    } else {
      state.save();
      // print('year od  $yearOfPassing $course');
      pageController.animateToPage(currentPage.value + 1,
          duration: kThemeAnimationDuration, curve: Curves.easeIn);
    }
  }

  completeStep3() {
    pageController.animateToPage(currentPage.value + 1,
        duration: kThemeAnimationDuration, curve: Curves.easeIn);
  }

  completeStep4() async {
    final state = formKey4.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode4.value = AutovalidateMode.always;
    } else {
      state.save();
      buttonKey.currentState?.showLoader();
      try {
        final result =
            await ApiCall.get('v1/user', query: {'referralCode': referralCode});
        print("referget ${result.data}");
        final response = ReferralResponse.fromJson(result.data);

        print('refer res ${response.data![0].id}');

        if (response.data!.isEmpty) {
          SnackBarHelper.show("Enter valid referral code");
        } else {
          await AuthHelper.signUpUser({
            "email": email,
            "password": password,
            "phone": phone,
            "gender": gender,
            "dob": dob?.toIso8601String(),
            "maritalStatus": maritalStatusSelected,
            "name": name,
            "bio": bio,
            "education": {
              "highestEducation": highestEducation,
              "course": course,
              "university": university,
              "yearOfPassing": yearOfPassing
            },
            "primaryJobPreference": selectedJobs.first.name,
            "secondaryJobPreference": selectedJobs.last.name,
            "referredBy": response.data![0].id
          });
          AuthHelper.checkUserLevel();
        }
      } catch (e, s) {
        log("completeStep3", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      } finally {
        buttonKey.currentState?.hideLoader();
      }
    }
  }

  skipStep3() async {
    skipButtonKey.currentState?.showLoader();
    try {
      // SharedPreferenceHelper.skipAvatar();
      print({'name': name, 'gender': gender, 'dob': dob?.toIso8601String()});
      if (SharedPreferenceHelper.user?.user == null) {
        await AuthHelper.signUpUser({
          "email": email,
          "password": password,
          "phone": phone,
          "gender": gender,
          "dob": dob?.toIso8601String(),
          "maritalStatus": maritalStatusSelected,
          "name": name,
          "bio": bio,
          "education": {
            "highestEducation": highestEducation,
            "course": course,
            "university": university,
            "yearOfPassing": yearOfPassing
          },
          "primaryJobPreference": selectedJobs.first.name,
          "secondaryJobPreference": selectedJobs.last.name,
        });
      }
      AuthHelper.checkUserLevel();
      //Get.toNamed(SuggestedGroupPage.routeName);
    } catch (e, s) {
      log("skipStep3", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      skipButtonKey.currentState?.hideLoader();
    }
  }
}
