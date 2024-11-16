import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/dashboard_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

import '../../../app_configs/environment.dart';
import '../../../widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sisira Sahoo
/// On 11/05/22 6:41 PM
///
class SuccessPage extends StatelessWidget {
  static const routeName = '/successPage';
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.successVector),
          const SizedBox(
            height: 50,
          ),
          Text(
            S.of(context).subscriptionSuccessful,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: AppPrimaryButton(
                color: Colors.black,
                onPressed: () {
                  SharedPreferenceHelper.user?.user?.role == 3
                      ? Get.offAllNamed(DashboardForOrgPage.routeName)
                      : Get.offAllNamed(DashboardPage.routeName);
                },
                child: Text(
                  S.of(context).backToHome,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      fontFamily: Environment.fontFamily),
                )),
          ),
        ],
      ),
    );
  }
}
