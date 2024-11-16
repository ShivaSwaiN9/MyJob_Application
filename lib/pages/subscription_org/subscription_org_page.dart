import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/coupon_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/coupon/coupon_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/subscription/subscription_page.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_controller.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_coupon_widget.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';

///
/// Created by Sisira Sahoo
/// On 20/07/22 12:54 PM
///

class SubscriptionOrgPage extends StatefulWidget {
  static const routeName = "/subscriptionPageOrg";

  const SubscriptionOrgPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionOrgPage> createState() => _SubscriptionOrgPageState();
}

class _SubscriptionOrgPageState extends State<SubscriptionOrgPage> {
  late UserController userController;
  late SubscriptionOrgController subscriptionOrgController;
  @override
  void initState() {
    super.initState();

    userController = Get.find<UserController>();
    subscriptionOrgController =
        Get.put(SubscriptionOrgController(userController));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    AppAssets.subBackground,
                    fit: BoxFit.cover,
                    width: Get.width,
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Image.asset(AppAssets.subButtonImageHalf)),
                  Positioned.fill(
                      child: ListView(
                    physics: const BouncingScrollPhysics(),
                    // padding: const EdgeInsets.all(16),
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          subscriptionOrgController.isSignup!
                              ? const SizedBox()
                              : AppBackButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                          const Spacer(),
                          subscriptionOrgController.isSignup!
                              ? TextButton(
                                  onPressed: () {
                                    SharedPreferenceHelper.skipSubscription();
                                    Get.offAllNamed(
                                        DashboardForOrgPage.routeName);
                                  },
                                  child: const Text("Skip"),
                                )
                              : const SizedBox()
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).myJobnmembership,
                                      style: const TextStyle(
                                          color: Color(0xff262626),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      S
                                          .of(context)
                                          .premiumSubscriptionFornyourPremiumVersion,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
// type: MaterialType.circle,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                              colors: [
                                                Color(0xffFFC01D),
                                                Color(0xffFFDB1D),
                                                Color(0xffFF6853),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              tileMode: TileMode.clamp),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: UserCircleAvatar(
                                            userController.state?.avatar,
                                            radius: 58,
                                            name: userController.state?.name ??
                                                "",
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          right: 9,
                                          left: 9,
                                          bottom: -10,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(11.5),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xffFF971E),
                                                      Color(0xffFF8754),
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 2, 7, 3),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.done,
                                                      size: 15,
                                                      color: Colors.white,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      S.of(context).verified,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              )))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(colors: [
                                Color(0xffC9E1F9),
                                Color(0xffB3D6F8),
                              ])),
                          child: Column(
                            children: [
                              Material(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: const Color(0xff92C3F1),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 17),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(AppAssets.emoji2),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        S.of(context).premiumAdvantage,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              CardLineTile(
                                  asset: AppAssets.subPerson,
                                  text: S
                                      .of(context)
                                      .getAPremiumFeaturedProfileAndImprovenyourVisibilityToThe),
                              CardLineTile(
                                  asset: AppAssets.subStar,
                                  text: S
                                      .of(context)
                                      .rankAtTheTopInTheSearchResult),
                              CardLineTile(
                                  asset: AppAssets.subAct,
                                  text: S
                                      .of(context)
                                      .profileEnhancementByMyjobSpecialistFornbetterResponse),
                              CardLineTile(
                                  asset: AppAssets.subChart,
                                  text: S
                                      .of(context)
                                      .computerizedRefreshToBoostYourVisibility),
                              CardLineTile(
                                  asset: AppAssets.subMic,
                                  text: S.of(context).priorityCustomerSupport),
                              CardLineTile(
                                  asset: AppAssets.subDocument,
                                  text: S
                                      .of(context)
                                      .carrierTipsAndResumeBuildingHandbook),
                              const SizedBox(
                                height: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  image: const DecorationImage(
                      image: const AssetImage(AppAssets.subButtonImage),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(AppAssets.emoji1),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        S.of(context).pricingStructure,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffFFFFFF)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  subscriptionOrgController.planController.obx(
                      (state) => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${S.of(context).normalPrice}:",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9DB0C7)),
                                    ),
                                    Text(
                                      "₹${state![1].basePrice ?? '0'} / ${state[1].monthCount ?? 0} ${S.of(context).months}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff9DB0C7)),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Material(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xff465971),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 10, 16, 9),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.of(context).offerPrice,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffFFFFFF)),
                                        ),
                                        Text(
                                          "₹${state[1].price} / ${state[1].monthCount ?? 0} ${S.of(context).months}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      onLoading: const SizedBox()),
                  const SizedBox(
                    height: 12,
                  ),
                  if (Platform.isAndroid)
                    SubscriptionOrgCouponWidget(
                      onTap: () {
                        print(
                            "subscriptionOrgController.selectedCoupon ${subscriptionOrgController.selectedCoupon}");
                        Get.toNamed(CouponPage.routeName, arguments: {
                          "coupon": subscriptionOrgController.selectedCoupon
                        })!
                            .then((value) {
                          if (value != null && value is CouponDatum) {
                            subscriptionOrgController
                                .updateSelectedCoupon(value);
                          }
                        });
                      },
                      onDelete: () {
                        subscriptionOrgController.updateSelectedCoupon(null);
                      },
                    )
                ],
              ),
            ),
            AppPrimaryButton(
                fixedSize: Size(MediaQuery.of(context).size.width, 58),
                color: const Color(0xff60A9FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                key: subscriptionOrgController.buttonKey,
                onPressed: () {
                  subscriptionOrgController.completeBooking();
                },
                child: Text(S.of(context).payNow))
          ],
        ));
  }
}
