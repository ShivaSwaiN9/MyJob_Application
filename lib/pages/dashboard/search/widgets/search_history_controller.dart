import 'package:get/get.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

class SearchHistoryController extends GetxController
    with StateMixin<List<String>> {
  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  void loadHistory() {
    change(SharedPreferenceHelper.searchHistory, status: RxStatus.success());
  }

  void addToHistory(String string) {
    final list = SharedPreferenceHelper.searchHistory;
    if (string.isEmpty) {
      return;
    }
    if (!list.contains(string)) {
      list.insert(0, string);
      SharedPreferenceHelper.storeSearchHistory(list);
      change(list, status: RxStatus.success());
    }
  }

  void removeHistory(String chapter) {
    final list = SharedPreferenceHelper.searchHistory;
    list.remove(chapter);
    SharedPreferenceHelper.storeSearchHistory(list);
    change(list, status: RxStatus.success());
  }

  void clearHistory() {
    SharedPreferenceHelper.preferences
        ?.remove(SharedPreferenceHelper.SEARCH_HISTORY_KEY);
    change([], status: RxStatus.success());
  }
}
