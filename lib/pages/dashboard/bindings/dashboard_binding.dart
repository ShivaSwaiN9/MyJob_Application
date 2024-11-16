import 'package:my_job_flutter/pages/dashboard/controllers/author_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/banner_controller.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/featured_job_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/applied_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/completed_widget_controller.dart';

import '../controllers/companies_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => ActiveControllerJobSeeker());
    Get.lazyPut(() => AppliedWidgetController());
    Get.lazyPut(() => CompletedWidgetController());
    Get.lazyPut(() => AuthorController());
    Get.lazyPut(() => FeaturedJobController());
    Get.lazyPut(() => BannerController());
    Get.lazyPut(() => CompaniesController());
  }
}
