import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/coupon_dm.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

class CouponController extends GetxController
    with StateMixin<List<CouponDatum>> {
  int limit = 20, skip = 0;
  bool shouldLoadMore = true;
  String searchQuery = '';
  final ScrollController scrollController = ScrollController();
  CouponDatum? couponDatum;
  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic>? map = Get.arguments;
    if (map != null) {
      couponDatum = map["coupon"];
    }
    getCoupon(searchQuery);
    scrollController.addListener(() {
      final maxGeneralScroll = scrollController.position.maxScrollExtent;
      final currentGeneralScroll = scrollController.position.pixels;
      if (maxGeneralScroll <= currentGeneralScroll) {
        getMoreCoupons(searchQuery);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    final max = scrollController.position.maxScrollExtent;
    final current = scrollController.offset;
    if (max - current < 200) {
      getMoreCoupons(searchQuery);
    }
  }

  void getCoupon(String query) async {
    skip = 0;
    shouldLoadMore = true;
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(ApiRoutes.coupon,
          isAuthNeeded: SharedPreferenceHelper.user != null,
          query: {
            '\$skip': skip,
            '\$limit': limit,
            '\$sort[createdAt]': -1,
            // 'status': 1
            if (query.isNotEmpty) 'code[\$in]': query,
          });
      final response = CouponResponse.fromJson(result.data);
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

  void getMoreCoupons(String query) async {
    if (shouldLoadMore && !status.isLoadingMore) {
      try {
        skip = state!.length;
        change(state, status: RxStatus.loadingMore());
        final result = await ApiCall.get(ApiRoutes.coupon,
            isAuthNeeded: SharedPreferenceHelper.user != null,
            query: {
              '\$limit': limit,
              '\$skip': skip,
              '\$sort[createdAt]': -1,
              // 'status': 1
              if (query.isNotEmpty) 'code[\$in]': query,
            });
        final response = CouponResponse.fromJson(result.data);
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
