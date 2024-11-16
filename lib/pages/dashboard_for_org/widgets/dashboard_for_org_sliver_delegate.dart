import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';

///
/// Created by Sisira Sahoo (sisira@smarttersstudio.com)
/// On 25-02-2022 05:32 PM
///

class DashboardForOrgSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  DashboardForOrgSliverDelegate({
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    final alias = SharedPreferenceHelper.user?.user;
    final backgroundColor = const Color(0xffE0F0FF);
    return Container(
      height: expandedHeight,
      color: backgroundColor,
      child: Stack(
        children: [
          SafeArea(
            child: Container(
              height: appBarSize < kToolbarHeight ? kToolbarHeight : appBarSize,
              child: AppBar(
                backgroundColor: backgroundColor,
                leadingWidth: 34,
                elevation: 0.0,
                iconTheme: const IconThemeData(color: Colors.white),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 10 * (1 - percent)),
                      child: Text(
                        greetingMessage(context),
                        style: TextStyle(
                            fontSize: 18 * (1 - percent).clamp(0.8, 1.0),
                            color: const Color(0xff545454),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Opacity(
                      opacity: hideTitleWhenExpanded ? percent : 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text(
                            '${alias?.companyName}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                actions: [
                  Material(
                    borderRadius: BorderRadius.circular(14),
                    child: IconButton(
                        iconSize: 25,
                        // padding: const EdgeInsets.all(10),
                        onPressed: () {
                          showAppAlertDialog(
                                  title: "Logout",
                                  description: "areYouSureWantToLogout")
                              .then((value) {
                            if (value == true) {
                              AuthHelper.logoutUser();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                        )),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Opacity(
              opacity: percent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30 * percent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

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
}
