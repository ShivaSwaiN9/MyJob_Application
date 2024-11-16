import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller_for_org.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/completed_widget_for_org_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/dashboard_for_org_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/requested_widget_controller.dart';

class DashboardForOrgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardForOrgController());
    Get.lazyPut(() => RequestedWidgetController());
    Get.lazyPut(() => CompletedWidgetForOrgController());
    Get.lazyPut(() => ActiveControllerForOrg());
  }
}
