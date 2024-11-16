///
/// Created by Sisira Sahoo
/// On 18/04/22 5:09 PM
///

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/job_dm.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class NewJobPreferenceController extends GetxController
    with StateMixin<List<JobDatum>> {
  List<JobDatum> jobs = List.empty();
  List<JobDatum> selectedJobs = [];
  JobDatum? selectedJob1;
  JobDatum? selectedJob2;

  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  @override
  void onInit() {
    super.onInit();
    getAllJob();
  }

  Future getAllJob() async {
    try {
      final result = await ApiCall.get(ApiRoutes.job);
      jobs = List<JobDatum>.from(
          result.data['data'].map((e) => JobDatum.fromJson(e)));
      change(jobs, status: RxStatus.success());
    } catch (e, s) {
      log("getAllJob", error: e, stackTrace: s);
    }
  }

  completeStep4() async {
    try {
      buttonKey.currentState?.showLoader();
      await AuthHelper.updateUser({
        "primaryJobPreference": selectedJobs.first.name,
        "secondaryJobPreference": selectedJobs.last.name,
      });
      SnackBarHelper.show("Profile updated successfully.");
      Get.back();
    } catch (e, s) {
      log('Error $e', stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      buttonKey.currentState?.hideLoader();
    }
  }
}
