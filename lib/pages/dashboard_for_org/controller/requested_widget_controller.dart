import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

class RequestedWidgetController extends GetxController
    with StateMixin<List<EmployeeRequestDatum>> {
  int limit = 20, skip = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    getEmployeeRequested();
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreEmployeeRequested();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void getEmployeeRequested() async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(ApiRoutes.employeeRequest,
          isAuthNeeded: SharedPreferenceHelper.user != null,
          query: {
            '\$skip': skip,
            '\$limit': limit,
            '\$sort[createdAt]': -1,
            'status': 0
          });
      final response = EmployeeRequestResponse.fromJson(result.data);
      if (response.data!.length < limit) {
        shouldLoadMore = false;
      }
      change(response.data,
          status:
              response.data!.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("message", error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void getMoreEmployeeRequested() async {
    if (shouldLoadMore && !status.isLoadingMore) {
      try {
        skip = state!.length;
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(ApiRoutes.employeeRequest,
            isAuthNeeded: SharedPreferenceHelper.user != null,
            query: {
              '\$limit': limit,
              '\$skip': skip,
              '\$sort[createdAt]': -1,
              'status': 0
            });
        final response = EmployeeRequestResponse.fromJson(result.data);
        if (response.data!.length < limit) {
          shouldLoadMore = false;
        }
        change((state ?? []) + response.data!, status: RxStatus.success());
      } catch (e) {
        change(state, status: RxStatus.success());
      }
    }
  }

  addAppliedRequest(EmployeeRequestDatum datum) {
    if (state == null) return;
    final index = state!.indexOf(datum);
    if (index == -1) {
      state!.insert(0, datum);
    } else {
      state![index] = datum;
    }
    change(state, status: RxStatus.success());
  }

  void removeRequest(EmployeeRequestDatum? datum) {
    if (state == null) return;
    state!.remove(datum);
    change(state, status: RxStatus.success());
  }

  void updateRequest(EmployeeRequestDatum? datum) {
    if (state == null || datum == null) return;
    final index = state!.indexOf(datum);
    if (index == -1) return;

    state![index] = datum;
    change(state, status: RxStatus.success());
  }
}
