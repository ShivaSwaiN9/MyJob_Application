import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:my_job_flutter/pages/dashboard/search/search_page.dart';
import 'package:my_job_flutter/pages/notification/notification_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:percent_indicator/percent_indicator.dart';

///
/// Created by Sunil Kumar
/// On 28-02-2022 02:25 PM
///

class DashboardSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  DashboardSliverPersistentHeader({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 3 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    // final theme = Theme.of(context);
    final user = SharedPreferenceHelper.user?.user;

    return SizedBox(
      height: expandedHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 32,
              child: Image.asset(
                AppAssets.dashboardBackgroundImage,
                fit: BoxFit.cover,
                // color: Color(0xff),
              )),
          Positioned(
            bottom: 170 * percent,
            right: 16,
            left: 16,
            child: Opacity(
              opacity: percent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).hello,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          (user?.role == 1 ? user?.name : user?.companyName)??"User",
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        AppAssets.handIcon,
                        width: 26,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (user?.getPercentage() != 100)
            Positioned(
              bottom: 80 * percent,
              right: 16,
              left: 16,
              child: Opacity(
                opacity: percent,
                child: Material(
                  color: const Color(0xff5DB1FF),
                  borderRadius: BorderRadius.circular(13),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 10),
                    child: Row(
                      children: [
                        CircularPercentIndicator(
                          radius: 20.0,
                          lineWidth: 3.0,
                          percent: ((user?.getPercentage()??0)/ 100),
                          center: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          progressColor: Colors.white,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).yourProfileIsPercentageComplete(
                                  user?.getPercentage().toStringAsFixed(0)??0),
                              style: const TextStyle(color: Colors.white),
                            ),
                            if (user?.getPercentage() != 100)
                              const SizedBox(
                                height: 6,
                              ),
                            if (user?.getPercentage() != 100)
                              GestureDetector(
                                onTap: () {
                                  Get.find<DashboardController>().onTap(3);
                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    child: Text(
                                      S.of(context).completeNow,
                                      style:
                                          TextStyle(color: Color(0xff1F92FD)),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
              bottom: percent + (50 * (1 - percent)),
              right: 16 + (50 * (1 - percent)),
              left: 16,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(SearchPage.routeName);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                            spreadRadius: 0,
                            color: Colors.grey.withOpacity(0.4))
                      ]),
                  padding: const EdgeInsets.fromLTRB(25, 18, 0, 18),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAssets.searchIcon),
                      const SizedBox(width: 20),
                      Text(
                        S.of(context).searchForJobs,
                        style: TextStyle(color: Color(0xffc1c1c1)),
                      ),
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 22 + (16 * percent),
              right: 16,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(NotificationPage.routeName);
                  },
                  child: Material(
                    color: const Color(0xff5DB1FF),
                    borderRadius: BorderRadius.circular(13),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.notificationVector,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent =>
      (kToolbarHeight * 2) + 12 + Get.mediaQuery.viewPadding.top;

  String greetingMessage(BuildContext context) {
    final timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return S.of(context).goodMorning;
    } else if ((timeNow > 12) && (timeNow <= 17)) {
      return S.of(context).goodAfternoon;
    } else if ((timeNow > 17) && (timeNow < 21)) {
      return S.of(context).goodEvening;
    } else {
      return S.of(context).goodNight;
    }
  }

  @override
  bool shouldRebuild(DashboardSliverPersistentHeader oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight;
  }
}
