import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/requested_widget_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class AddRequestController extends GetxController {
  String? title;
  String? desc;
  String? experience;
  String? location;
  String? vacancy;
  String? maxSalary;
  String? minSalary;
  static const List<int> manPowerType = [1, 2, 3];
  late RxInt selectedType;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Rx<AutovalidateMode> autoValidateMode;

  @override
  void onInit() {
    super.onInit();
    selectedType = RxInt(3);
    autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  }

  @override
  void dispose() {
    autoValidateMode.close();
    super.dispose();
  }

  void onTitleSaved(String? newValue) {
    title = newValue!.trim();
  }

  void onDescSaved(String? newValue) {
    desc = newValue!.trim();
  }

  void onTypeSaved(int? newValue) {
    selectedType.value = newValue!;
  }

  void onExperienceSaved(String? newValue) {
    experience = newValue?.trim();
  }

  void onLocationSaved(String? newValue) {
    location = newValue?.trim();
  }

  void onVacancySaved(String? newValue) {
    vacancy = newValue?.trim();
  }

  void onMaxSalarySaved(String? newValue) {
    maxSalary = newValue?.trim();
  }

  void onMinSalarySaved(String? newValue) {
    minSalary = newValue?.trim();
  }

  Future<void> createRequest() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode.value = AutovalidateMode.always;
    } else {
      state.save();
      // int minS = int.parse(minSalary!);
      // int maxS = int.parse(maxSalary!);
      // if (minS >= maxS) {
      //   SnackBarHelper.show('Please correct salary');
      // }
      buttonKey.currentState?.showLoader();
      try {
        final result = await ApiCall.post(ApiRoutes.employeeRequest, body: {
          "title": title,
          "noOfEmployees": int.parse(vacancy!),
          "description": desc,
          "salary": 12,
          "type": selectedType.value,
          "workLocation": location,
          "experience": int.parse(experience!),
          "minSalary": int.parse(minSalary!),
          "maxSalary": int.parse(maxSalary!)
        });
        final response = EmployeeRequestDatum.fromJson(result.data);
        Get.find<RequestedWidgetController>().addAppliedRequest(response);
        Get.back();
        print("result create request $result");
      } catch (e) {
        log("message create request", error: e);
        buttonKey.currentState?.hideLoader();
      }
    }
  }
}
