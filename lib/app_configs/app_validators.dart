import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 15-11-2021 01:24 PM
///
mixin AppFormValidators {
  static String? validateEmpty(dynamic data, BuildContext context) {
    if (data == null) return S.of(context).required;
    if (data is String) {
      if (data.toString().trim().isEmpty) return S.of(context).required;
    }
    if (data is Iterable || data is Map) {
      if (data.isEmpty) return S.of(context).required;
    }
  }

  static String? validateMail(String? email, BuildContext context) {
    if (email == null) return S.of(context).required;
    if (email.isEmpty) {
      return S.of(context).required;
    } else if (!GetUtils.isEmail(email.trim())) {
      return S.of(context).invalidEmailId;
    }
  }

  static String? validatePhone(String? phone, BuildContext context) {
    if (phone == null) return S.of(context).required;
    if (phone.isEmpty) {
      return S.of(context).required;
    } else if (!GetUtils.isPhoneNumber(phone)) {
      return S.of(context).invalidPhoneNo;
    }
  }
}
