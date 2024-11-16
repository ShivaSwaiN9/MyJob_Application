import 'dart:convert';

import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const USER_KEY = 'user';
  static const LOCALE_KEY = 'locale';
  static const SKIP_REFER = 'skip-refer';
  static const SKIP_AVATAR = 'skip-avatar';
  static const SKIP_SUBSCRIPTION = 'skip-subscription';
  static const SEARCH_HISTORY_KEY = 'search-history';
  static const RECENT_LOOKED_JOBS_KEY = 'recent_looked_jobs_key';
  static const SKIP_LOGIN = 'skip-login';

  static SharedPreferences? preferences;
  //
  // static void storeAccessToken(String? token) {
  //   if (token != null) {
  //     preferences?.setString(ACCESS_TOKEN_KEY, token);
  //   }
  // }

  // static String? get accessToken => preferences?.getString(ACCESS_TOKEN_KEY);
  static void storeLocale(String? locale) {
    if (locale != null) {
      preferences?.setString(LOCALE_KEY, locale);
    }
  }

  static String? get locale => preferences?.getString(LOCALE_KEY);

  static void clear() {
    preferences?.clear();
  }

  static void logout() {
    // preferences?.remove(ACCESS_TOKEN_KEY);
    preferences?.remove(USER_KEY);
    preferences?.clear();
  }

  //
  // static void storeLocation(List<double> coordinates) {
  //   preferences?.setString(LOCATION_KEY,
  //       json.encode(List<dynamic>.from(coordinates.map((x) => x))));
  // }
  //
  // static List<double> get location =>
  //     preferences?.getString(LOCATION_KEY)?.isEmpty ?? true
  //         ? []
  //         : List<double>.from(
  //                 json.decode(preferences?.getString(LOCATION_KEY) ?? ''))
  //             .map((x) => x)
  //             .toList();

  static void storeUser({UserResponse? user, String? response}) {
    if (user != null)
      preferences?.setString(USER_KEY, userResponseToJson(user));
    else {
      if (response == null || response.isEmpty)
        throw 'No value to store. Either a User object or a String response is required to store in preference.';
      else
        preferences?.setString(USER_KEY, response);
    }
  }

  static skipSubscription() => preferences?.setBool(SKIP_SUBSCRIPTION, true);
  static bool get isSkipSub => preferences?.getBool(SKIP_SUBSCRIPTION) ?? false;

  static skipRefer() => preferences?.setBool(SKIP_REFER, true);
  static bool get isSkipRefer => preferences?.getBool(SKIP_REFER) ?? false;

  static UserResponse? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userResponseFromJson(preferences?.getString(USER_KEY) ?? '');

  static skipAvatar() => preferences?.setBool(SKIP_AVATAR, true);

  static bool get isSkipAvatar => preferences?.getBool(SKIP_AVATAR) ?? false;

  static List<String> get searchHistory =>
      preferences!.getStringList(SEARCH_HISTORY_KEY) ?? [];

  static void storeSearchHistory(List<String> list) {
    preferences?.setStringList(SEARCH_HISTORY_KEY, list);
  }

  static List<EmployeeRequestDatum> get storeJob =>
      preferences?.getString(RECENT_LOOKED_JOBS_KEY) == null
          ? []
          : List<EmployeeRequestDatum>.from(
              jsonDecode(preferences!.getString(RECENT_LOOKED_JOBS_KEY)!)
                  .map((x) => EmployeeRequestDatum.fromJson(x)));

  static void storeLookedRecentJob(List<EmployeeRequestDatum> list) {
    preferences?.setString(RECENT_LOOKED_JOBS_KEY,
        jsonEncode(List<dynamic>.from(list.map((x) => x.toJson()))));
  }

  static skipLogin() => preferences?.setBool(SKIP_LOGIN, true);

  static bool get isSkipLogin => preferences?.getBool(SKIP_LOGIN) ?? false;
}
