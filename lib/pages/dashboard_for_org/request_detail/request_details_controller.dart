import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/completed_widget_for_org_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/requested_widget_controller.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';

import '../controller/applied_widget_controller.dart';
import '../controller/completed_widget_controller.dart';
import '../controller/pending_widget_controller.dart';

class RequestDetailsController extends GetxController
    with StateMixin<EmployeeRequestDatum> {
  late String id;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic>? map = Get.arguments as Map<String, dynamic>;
    if (map != null) {
      id = map['requestDatum'];
    }
    getJobDetails();
  }

  Future getJobDetails() async {
    try {
      change(null, status: RxStatus.loading());
      // Map<String, dynamic> query = {'\$populate': 'attributes.attribute'};
      final result = await ApiCall.get(ApiRoutes.employeeRequest, id: id);
      final response = EmployeeRequestDatum.fromJson(result.data);

      change(response, status: RxStatus.success());
      // Get.back();
    } catch (e, s) {
      log('getTemplateDetails', error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  deleteRequest() {
    try {
      change(state, status: RxStatus.loading());

      showAppAlertDialog(
              title: 'Delete', description: 'Are you sure want to delete?')
          .then((value) async {
        if (value == true) {
          await ApiCall.delete(ApiRoutes.employeeRequest, id: id);
          SnackBarHelper.show('Deleted successfully');
          if (Get.isRegistered<AppliedWidgetController>()) {
            Get.find<AppliedWidgetController>().removeAppliedRequest(state);
          }
          if (Get.isRegistered<PendingWidgetController>()) {
            Get.find<PendingWidgetController>().removePendingRequest(state);
          }
          if (Get.isRegistered<CompletedWidgetController>()) {
            Get.find<CompletedWidgetController>().removeCompletedRequest(state);
          }
          if (Get.isRegistered<RequestedWidgetController>()) {
            Get.find<RequestedWidgetController>().removeRequest(state);
          }
          if (Get.isRegistered<ActiveControllerJobSeeker>()) {
            Get.find<ActiveControllerJobSeeker>().removeRequest(state);
          }
          if (Get.isRegistered<CompletedWidgetForOrgController>()) {
            Get.find<CompletedWidgetForOrgController>().removeRequest(state);
          }
          Get.back();
        }
      });
    } catch (e, s) {
      log("message", error: e, stackTrace: s);
      SnackBarHelper.show(e.toString());
    } finally {
      change(state, status: RxStatus.success());
    }
  }

  applyNow() async {
    if (SharedPreferenceHelper.user?.accessToken == null) {
      Get.toNamed(NewPhonePage.routeName,
          arguments: {"isLoginFromStart": true});
    } else {
      try {
        final result = await ApiCall.post(ApiRoutes.employeeRequestApplicant,
            body: {'job': id});
        final response = EmployeeRequestDatum.fromJson(result.data["job"]);
        print("apply respo ${response.toJson()},,,,, ${result.data["job"]}");
        Get.back();
        change(response, status: RxStatus.success());
        SnackBarHelper.show('Job applied successfully');
        if (Get.isRegistered<AppliedWidgetController>()) {
          Get.find<AppliedWidgetController>().addAppliedRequest(response);
        }
        if (Get.isRegistered<PendingWidgetController>()) {
          Get.find<PendingWidgetController>().updateRequest(response);
        }
        if (Get.isRegistered<CompletedWidgetController>()) {
          Get.find<CompletedWidgetController>().updateRequest(response);
        }
        if (Get.isRegistered<RequestedWidgetController>()) {
          Get.find<RequestedWidgetController>().updateRequest(response);
        }
        if (Get.isRegistered<ActiveControllerJobSeeker>()) {
          Get.find<ActiveControllerJobSeeker>().removeRequest(response);
        }
        if (Get.isRegistered<CompletedWidgetForOrgController>()) {
          Get.find<CompletedWidgetForOrgController>().updateRequest(response);
        }
      } catch (e, s) {
        log("message", error: e, stackTrace: s);
        SnackBarHelper.show(e.toString());
      }
    }
  }
}
