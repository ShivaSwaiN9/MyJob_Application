import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/featured_job_controller.dart';

class FeaturedJobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeaturedJobController());
  }
}
