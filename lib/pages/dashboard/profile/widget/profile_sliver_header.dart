import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';

import '../../../../widgets/user_circle_avatar.dart';

///
/// Created by Sisira Sahoo
/// On 05/04/22 11:28 AM
///

class ProfileSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final UserData state;
  const ProfileSliverPersistentHeader(
      {required this.state, required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 3 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    final controller = Get.find<UserController>();
    return SizedBox(
      height: expandedHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 50,
              child: Image.asset(
                AppAssets.dashboardBackgroundImage,
                fit: BoxFit.cover,
              )),
          Positioned(
            left: 10,
            right: 10,
            top: 5,
            // bottom: 10,
            child: SafeArea(
              child: Row(
                children: [
                  const AppBackButton(
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: PopupMenuButton(
                        tooltip: S.of(context).changeLanguage,
                        itemBuilder: (context) {
                          return [
                            if (Intl.getCurrentLocale() == "or_IN")
                              const PopupMenuItem(
                                child: Text("English"),
                                value: 1,
                              ),
                            if (Intl.getCurrentLocale() == "en")
                              const PopupMenuItem(
                                child: Text("Odia"),
                                value: 2,
                              ),
                          ];
                        },
                        child: const Icon(Icons.language, color: Colors.white),
                        onSelected: (i) {
                          if (i == 1) {
                            SharedPreferenceHelper.storeLocale("en");
                            S.load(const Locale("en"));
                            Get.find<GetMaterialController>().restartApp();
                          }
                          if (i == 2) {
                            SharedPreferenceHelper.storeLocale("or_IN");
                            S.load(const Locale("or_IN"));
                            Get.find<GetMaterialController>().restartApp();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<UserController>(
              init: controller,
              builder: (controller) {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  // top: 50,
                  child: Opacity(
                    opacity: percent,
                    child: Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: GestureDetector(
                          onTap: () {
                            controller.chooseProfilePicture();
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              if (state.subscription != null &&
                                  state.subscription?.status == 1)
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xffFFC01D),
                                          Color(0xffFFDB1D),
                                          Color(0xffFF6853),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter),
                                  ),
                                  // type: MaterialType.circle,
                                  // color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Material(
                                      type: MaterialType.circle,
                                      color: Colors.white,
                                      child: UserCircleAvatar(
                                        state.avatar,
                                        radius: 58,
                                        name: state.name ?? "",
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Material(
                                  type: MaterialType.circle,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: UserCircleAvatar(
                                      state.avatar,
                                      radius: 58,
                                      name: state.name ?? "",
                                    ),
                                  ),
                                ),
                              if (controller.uploadingDp)
                                Positioned.fill(
                                    child: CircularProgressIndicator(
                                        color: Get.theme.primaryColor)),
                              Positioned(
                                  right: -4,
                                  bottom: -4,
                                  child: Material(
                                    color: Colors.white,
                                    type: MaterialType.circle,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: state.subscription != null &&
                                                    state.subscription
                                                            ?.status ==
                                                        1
                                                ? const Color(0xffFFECBC)
                                                : const Color(0xffC6E3FE),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                                AppAssets.image,
                                                color: state.subscription !=
                                                            null &&
                                                        state.subscription
                                                                ?.status ==
                                                            1
                                                    ? const Color(0xffFF7D54)
                                                    : const Color(0xff319EFF),
                                                width: 18),
                                          )),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => (kToolbarHeight * 2) + Get.mediaQuery.viewPadding.top;

  @override
  bool shouldRebuild(ProfileSliverPersistentHeader oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight;
  }
}
