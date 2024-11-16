import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/org_profile/org_profile_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';

import '../add_request_sheet/add_request_sheet.dart';

///
/// Created by Sunil Kumar
/// On 28-02-2022 02:25 PM
///

class OrgDashboardSliverPersistentTab extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Function(int i)? onChanged;
  final int currentIndex;
  final UserController controller;

  OrgDashboardSliverPersistentTab(
      {required this.expandedHeight,
      required this.controller,
      this.onChanged,
      this.currentIndex = 0});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 3 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    final theme = Theme.of(context);
    return Container(
      height: expandedHeight,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xffe7f1fd)),
      child: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 12,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    controller.obx((state) {
                      return state == null
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(DashboardForOrgPage.routeName +
                                    OrgProfile.routeName);
                              },
                              child: UserCircleAvatar(
                                state.avatar,
                                radius: 25,
                                name: state.companyName ?? '',
                              ),
                            );
                    }, onLoading: const SizedBox()),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Opacity(
                        opacity: 1 - percent,
                        child: Text(
                          "${SharedPreferenceHelper.user?.user?.companyName}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Opacity(
                      opacity: 1 - percent,
                      child: Material(
                        borderRadius: BorderRadius.circular(14),
                        child: IconButton(
                            iconSize: 25,
                            // padding: const EdgeInsets.all(10),
                            onPressed: () {
                              Get.bottomSheet(const AddRequestSheet(),
                                  isScrollControlled: true);
                            },
                            icon: const Icon(Icons.add)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 64 * percent,
            right: 16,
            left: 16,
            child: Opacity(
              opacity: percent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greetingMessage(),
                    style: const TextStyle(
                      color: Color(0xff545454),
                    ),
                  ),
                  Text(
                    "${SharedPreferenceHelper.user?.user?.companyName}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppPrimaryButton(
                      onPressed: () {
                        Get.bottomSheet(const AddRequestSheet(),
                            isScrollControlled: true);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppAssets.bagVector),
                          const SizedBox(
                            width: 6,
                          ),
                          const Text(
                            'Create new employee request',
                            style: TextStyle(
                                fontSize: 13,
                                letterSpacing: 0,
                                fontFamily: Environment.fontFamily,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: onChanged,
                labelColor: Colors.black,
                automaticIndicatorColorAdjustment: true,
                unselectedLabelColor: const Color(0xffA7A7A7),
                unselectedLabelStyle: const TextStyle(color: Color(0xffA7A7A7)),
                indicator: const BoxDecoration(
                  color: Color(0xffFFFFFF),
                  // borderRadius: BorderRadius.circular(12),
                ),
                tabs: const [
                  Tab(
                    text: 'Requested',
                  ),
                  Tab(
                    text: 'Active',
                  ),
                  Tab(
                    text: 'Completed',
                  )
                ]),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent =>
      (kToolbarHeight * 2) + 12 + Get.mediaQuery.viewPadding.top;

  String greetingMessage() {
    final timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 17)) {
      return 'Good Afternoon';
    } else if ((timeNow > 17) && (timeNow < 21)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  bool shouldRebuild(OrgDashboardSliverPersistentTab oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        currentIndex != oldDelegate.currentIndex;
  }
}
