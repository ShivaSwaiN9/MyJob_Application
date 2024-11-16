import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/my_app_controller.dart';

class MyApplicationsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyApplicationController());
  }
}
