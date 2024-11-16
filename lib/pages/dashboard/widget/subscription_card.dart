import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/plan_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/subscription/subscription_page.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

///
/// Created by Sisira Sahoo
/// On 11/05/22 11:15 AM
///

class SubscriptionCard extends StatelessWidget {
  final PlanDatum state;
  int? status;
  SubscriptionCard({Key? key, required this.state, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("DATA ${state.toJson()}");
    return GestureDetector(
      onTap: () {
        SharedPreferenceHelper.user?.user?.role == 1
            ? Get.toNamed(SubscriptionPage.routeName,
                arguments: {"state": state})
            : Get.toNamed(SubscriptionOrgPage.routeName,
                arguments: {"isSignup": false});
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffFFE9E2),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 11, 14),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status == 0
                              ? S.of(context).myJobMembership
                              : status == -2
                                  ? S.of(context).cancelled
                                  : status == -1
                                      ? S.of(context).paymentFailed
                                      : "",
                          style: const TextStyle(
                              color: Color(0xffE75F36),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          status == 0
                              ? S
                                  .of(context)
                                  .getProfileBoostingCareerAdvicenManyMoreFeaturesAdvantage
                              : status == -2
                                  ? S
                                      .of(context)
                                      .yourSubscriptionHasBeenncancelledPleaseRenew
                                  : status == -1
                                      ? S
                                          .of(context)
                                          .pleaseClickHereToUpdateYourPayment
                                      : "",
                          style: const TextStyle(
                            color: Color(0xff000000),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Material(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffF16237),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(11, 10, 13, 11),
                        child: status == 0
                            ? RichText(
                                text: TextSpan(
                                    text: S.of(context).atJust,
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontFamily: Environment.fontFamily,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text: "\n₹ ${state.price!}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily:
                                                  Environment.fontFamily,
                                              color: Colors.white)),
                                      TextSpan(
                                          text:
                                              "\n${state.monthCount} ${S.of(context).months}")
                                    ]),
                              )
                            : status == -2
                                ? Text(
                                    S.of(context).renew,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: Environment.fontFamily,
                                        color: Colors.white),
                                  )
                                : status == -1
                                    ? Text(
                                        S.of(context).update,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: Environment.fontFamily,
                                            color: Colors.white),
                                      )
                                    : const SizedBox(),
                        // Column(
                        //   children: [
                        //     Text(
                        //       "at just",
                        //       style: TextStyle(
                        //           color: Color(0xffE75F36),
                        //           fontSize: 16,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
