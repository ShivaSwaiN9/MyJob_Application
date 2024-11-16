import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/notification_dm.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_detail_page.dart';
import 'package:my_job_flutter/utils/notification_services/in_app_notification.dart';

class NotificationTile extends StatelessWidget {
  final NotificationDatum data;
  const NotificationTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(DashboardForOrgPage.routeName + RequestDetailPage.routeName,
            arguments: {"requestDatum": data.entityId});
      },
      behavior: HitTestBehavior.translucent,
      child: Row(
        children: [
          Material(
            borderRadius: BorderRadius.circular(15),
            color: data.entityType == 2
                ? const Color(0xffDEFFC9)
                : data.entityType == 3
                    ? const Color(0xffFFE5E4)
                    : const Color(0xffE2F1FF),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: data.entityType == 2
                  ? SvgPicture.asset(
                      AppAssets.notificationDone,
                    )
                  : data.entityType == 3
                      ? SvgPicture.asset(
                          AppAssets.notificationReject,
                        )
                      : SvgPicture.asset(
                          AppAssets.notificationVector,
                          color: const Color(0xff77BFFF),
                        ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title!,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  data.description!,
                  style:
                      const TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
