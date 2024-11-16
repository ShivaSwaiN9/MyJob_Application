import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/banners_dm.dart';

class BannerController extends GetxController
    with StateMixin<List<BannersDatum>> {
  @override
  void onInit() {
    super.onInit();
    getBanners();
  }

  getBanners() async {
    try {
      final result = await ApiCall.get(ApiRoutes.banner);
      final response = List<BannersDatum>.from(
          result.data.map((e) => BannersDatum.fromJson(e)));
      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("message banners", error: e, stackTrace: s);
    }
  }
}
