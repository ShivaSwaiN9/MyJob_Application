import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sisira Sahoo
/// On 06/06/22 2:51 PM
///
class CancelDialog extends StatelessWidget {
  const CancelDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).areYouSureToCancelntransaction,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Color(0xff9A9A9A),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S
                    .of(context)
                    .myJobMembershipProvidesYouWithPremiumFeaturedProfileAnd,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 24,
              ),
              AppPrimaryButton(
                color: const Color(0xffEB6868),
                child: Text(S.of(context).cancelMembership),
                onPressed: () async {
                  await ApiCall.delete(ApiRoutes.cancelSub).then((value) {
                    final controller = Get.find<UserController>();
                    controller.updateSubscriptionStatus(-2);
                    Get.back();
                    Get.back();
                    SnackBarHelper.show("Subscription cancelled successful");
                  }).catchError((e) => log("error cancel", error: e));
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
