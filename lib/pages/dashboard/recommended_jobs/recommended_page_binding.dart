import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';

class RecommendedPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ActiveControllerJobSeeker());
  }
}
