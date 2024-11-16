import 'package:get/get.dart';
import 'package:my_job_flutter/pages/notification/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
