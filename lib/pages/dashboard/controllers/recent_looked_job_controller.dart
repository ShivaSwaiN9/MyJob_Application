import 'package:get/get.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

class RecentLookedJobController extends GetxController
    with StateMixin<List<EmployeeRequestDatum>> {
  @override
  void onInit() {
    super.onInit();
    loadJob();
  }

  void loadJob() {
    change(SharedPreferenceHelper.storeJob, status: RxStatus.success());
  }

  void addToHistory(EmployeeRequestDatum string) {
    final list = SharedPreferenceHelper.storeJob;
    if (!list.contains(string)) {
      list.insert(0, string);
      SharedPreferenceHelper.storeLookedRecentJob(list);
      change(list, status: RxStatus.success());
    }
  }

  //
  // void removeHistory(String chapter) {
  //   final list = SharedPreferenceHelper.storeJob;
  //   list.remove(chapter);
  //   SharedPreferenceHelper.storeSearchHistory(list);
  //   change(list, status: RxStatus.success());
  // }
  //
  // void clearHistory() {
  //   SharedPreferenceHelper.preferences
  //       ?.remove(SharedPreferenceHelper.RECENT_LOOKED_JOBS_KEY);
  //   change([], status: RxStatus.success());
  // }
}
