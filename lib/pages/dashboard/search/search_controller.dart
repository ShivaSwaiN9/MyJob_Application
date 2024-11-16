import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';

class SearchController extends GetxController
    with StateMixin<List<EmployeeRequestDatum>> {
  int skip = 0, limit = 8;
  bool shouldLoadMore = true;
  String query = "";

  @override
  void onInit() {
    super.onInit();
  }

  void getJobSearch(String query) async {
    this.query = query;
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(ApiRoutes.employeeRequest, query: {
        '\$skip': skip,
        '\$limit': limit,
        "status": 1,
        '\$search[value]': query
      });
      log("EEEE ${result.data}");
      final response = EmployeeRequestResponse.fromJson(result.data);
      if (response.data!.length < limit) {
        shouldLoadMore = false;
      }
      print("getjob searchobject${response.data}");
      change(response.data,
          status:
              response.data!.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("getFeeds", error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
