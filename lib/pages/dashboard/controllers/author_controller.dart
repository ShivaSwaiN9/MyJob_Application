import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/data_models/author_dm.dart';

class AuthorController extends GetxController
    with StateMixin<List<AuthorDatum>> {
  @override
  onInit() {
    super.onInit();
    getAuthor();
  }

  getAuthor() async {
    try {
      final result = await ApiCall.get(ApiRoutes.master);
      final response = List<AuthorDatum>.from(
          result.data.map((e) => AuthorDatum.fromJson(e)));

      change(response,
          status: response.isEmpty ? RxStatus.empty() : RxStatus.success());
    } catch (e, s) {
      log("authorgetmessage", error: e, stackTrace: s);
    }
  }
}
