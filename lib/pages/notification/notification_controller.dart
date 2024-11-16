import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

import '../../data_models/notification_dm.dart';

class NotificationController extends GetxController
    with StateMixin<List<NotificationDatum>> {
  int limit = 20, skip = 0;
  bool shouldLoadMore = true;
  final ScrollController scrollController = ScrollController();
  Map<String, dynamic> extraQuery = const {};

  @override
  void onInit() {
    super.onInit();
    getNotification();
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (currentGeneralScroll <= maxGeneralScroll) {
        getMoreNotification();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  getNotification() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(ApiRoutes.notification,
          isAuthNeeded: SharedPreferenceHelper.user != null,
          query: {
            '\$skip': skip,
            '\$limit': limit,
            '\$sort[createdAt]': -1,
          });
      final response = NotificationResponse.fromJson(result.data);
      if (response.data!.length < limit) {
        shouldLoadMore = false;
      }
      change(response.data,
          status:
              response.data!.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log('getNotification', error: e, stackTrace: s);
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  getMoreNotification() async {
    if (shouldLoadMore && !status.isLoadingMore) {
      try {
        skip = state!.length;
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(ApiRoutes.notification,
            isAuthNeeded: SharedPreferenceHelper.user != null,
            query: {
              '\$limit': limit,
              '\$skip': skip,
              '\$sort[createdAt]': -1,
            });
        final response = NotificationResponse.fromJson(result.data);
        if (response.data!.length < limit) {
          shouldLoadMore = false;
        }
        change((state ?? []) + response.data!, status: RxStatus.success());
      } catch (e) {
        change(state, status: RxStatus.success());
      }
    }
  }
}
