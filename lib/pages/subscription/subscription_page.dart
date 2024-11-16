import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/coupon_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/coupon/coupon_page.dart';
import 'package:my_job_flutter/pages/subscription/subscription_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';
import 'widget/subscription_coupon_widget.dart';

///
/// Created by Sisira Sahoo
/// On 09/05/22 2:40 PM
///
class SubscriptionPage extends StatefulWidget {
  static const routeName = "/subscriptionPage";

  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  late UserController userController;
  late SubscriptionController subscriptionController;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    subscriptionController = Get.put(SubscriptionController(userController));
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
                    clipBehavior: Clip.none,
                    children: [
                      const Align(
                          alignment: Alignment.topLeft, child: AppBackButton()),
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
// stops: [0.0, 1.0],
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
// color: Colors.red
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
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.subButtonImage),
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
                  Row(
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
                              "₹${subscriptionController.planDatum.basePrice ?? '0'} / ${subscriptionController.planDatum.monthCount ?? 0} ${S.of(context).months}",
                              style: const TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
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
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 9),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).offerPrice,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xffFFFFFF)),
                                ),
                                Text(
                                  "₹${subscriptionController.planDatum.price} / ${subscriptionController.planDatum.monthCount ?? 0} ${S.of(context).months}",
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
                  const SizedBox(
                    height: 12,
                  ),
                  if (Platform.isAndroid)
                    SubscriptionCouponWidget(
                      onTap: () {
                        Get.toNamed(CouponPage.routeName, arguments: {
                          "coupon": subscriptionController.selectedCoupon
                        })!
                            .then((value) {
                          if (value != null && value is CouponDatum) {
                            subscriptionController.updateSelectedCoupon(value);
                          }
                        });
                      },
                      onDelete: () {
                        subscriptionController.updateSelectedCoupon(null);
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
                key: subscriptionController.buttonKey,
                onPressed: () {
                  subscriptionController.completeBooking();
                },
                child: Text(S.of(context).payNow))
          ],
        ));
  }
}

class CardLineTile extends StatelessWidget {
  final String asset, text;

  const CardLineTile({Key? key, required this.asset, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 0, 16, 20),
      child: Row(
        children: [
          SvgPicture.asset(asset),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            maxLines: 2,
            style: const TextStyle(fontSize: 12, color: Color(0xff262626)),
          )
        ],
      ),
    );
  }
}
