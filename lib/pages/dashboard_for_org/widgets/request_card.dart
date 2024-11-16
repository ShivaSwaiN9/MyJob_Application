import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/recent_looked_job_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_detail_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:timeago/timeago.dart' as time_ago;

class RequestCard extends StatelessWidget {
  final EmployeeRequestDatum data;
  const RequestCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(DashboardForOrgPage.routeName + RequestDetailPage.routeName,
            arguments: {"requestDatum": data.id});

        final d = Get.find<RecentLookedJobController>();
        d.addToHistory(data);
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: const Color(0xffEAEAEA), width: 1),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff12264145).withOpacity(0.10),
                blurRadius: 10.0,
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    '${data.title}',
                    maxLines: 1,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xff545454),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SharedPreferenceHelper.user?.user?.role == 1
                    ? Flexible(
                        flex: 2,
                        child: Material(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(data.applicationStatus == 0
                              ? 0xffC6E3FE
                              : data.applicationStatus == 2
                                  ? 0xffD3F0C1
                                  : data.applicationStatus == 1
                                      ? 0xffFFE0B2
                                      : data.applicationStatus == 3
                                          ? 0xffFFEBEE
                                          : 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            child: Text(
                              data.applicationStatus == 0
                                  ? S.of(context).active
                                  : data.applicationStatus == 1
                                      ? S.of(context).applied
                                      : data.applicationStatus == 2
                                          ? S.of(context).accepted
                                          : data.applicationStatus == 3
                                              ? S.of(context).rejected
                                              : '',
                              style: TextStyle(
                                  color: Color(data.applicationStatus == 0
                                      ? 0xff268AFF
                                      : data.applicationStatus == 2
                                          ? 0xff609C3B
                                          : data.applicationStatus == 1
                                              ? 0xffFF9800
                                              : data.applicationStatus == 3
                                                  ? 0xFFF44336
                                                  : 0),
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SvgPicture.asset(AppAssets.locationVector),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    (data.workLocation ?? ""),
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color(0xff545454),
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                SvgPicture.asset(AppAssets.walletVector),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "₹ ${data.salary} ${S.of(context).monthly}",
                  style: const TextStyle(
                    color: Color(0xff545454),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                SvgPicture.asset(AppAssets.workVector),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  "${data.experience} ${S.of(context).yearsExperience}",
                  style: const TextStyle(
                    color: Color(0xff545454),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffDFF0FF),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      "${data.noOfEmployees} ${S.of(context).opening}",
                      style: const TextStyle(
                        color: Color(0xff1F61B4),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffEAEAEA),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Text(
                      data.type == 1
                          ? S.of(context).onPayRoll
                          : data.type == 2
                              ? S.of(context).offPayRoll
                              : data.type == 3
                                  ? S.of(context).directRecruitment
                                  : '',
                      style: const TextStyle(
                        color: Color(0xff7E7E7E),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    timeInAgoShort(data.updatedAt!),
                    style:
                        const TextStyle(color: Color(0xff89A4C5), fontSize: 10),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String timeInAgoShort(DateTime dateTime) {
    return time_ago.format(dateTime, allowFromNow: true);
  }
}
