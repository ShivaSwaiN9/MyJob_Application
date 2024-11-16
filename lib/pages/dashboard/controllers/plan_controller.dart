///
/// Created by Sisira Sahoo
/// On 09/05/22 2:14 PM
///

import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/plan_dm.dart';

class PlanController extends GetxController
    with StateMixin<List<PlanDatum>> {
  @override
  onInit() {
    super.onInit();
    getPlan();
  }

  getPlan() async {
    try {
      final result = await ApiCall.get(ApiRoutes.subscriptionPlan);
      final response = PlanResponse.fromJson(result.data);
      // List<PlanDatum>.from(result.data.map((e) => ));
      change(response.data,
          status:
              response.data!.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("Plan get message", error: e, stackTrace: s);
    }
  }
}
