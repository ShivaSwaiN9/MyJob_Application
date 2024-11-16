import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/plan_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/subscription/subscription_page.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';

///
/// Created by Sisira Sahoo
/// On 06/06/22 12:55 PM
///

class CancelSubscriptionPage extends StatefulWidget {
  static const routeName = '/cancelSub';
  const CancelSubscriptionPage({Key? key}) : super(key: key);

  @override
  State<CancelSubscriptionPage> createState() => _CancelSubscriptionPageState();
}

class _CancelSubscriptionPageState extends State<CancelSubscriptionPage> {
  late UserController controller;
  late PlanDatum state;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? map = Get.arguments;
    if (map != null) {
      state = map["planDatum"];
    }
    controller = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                AppAssets.subBackground,
                fit: BoxFit.cover,
                width: Get.width,
              ),
              const Spacer(),
              Stack(children: [
                SvgPicture.asset(
                  AppAssets.subBackground2,
                  fit: BoxFit.cover,
                  width: Get.width,
                ),
                Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    // bottom: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(AppAssets.emoji3),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              S.of(context).cancelSubscription,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).currentSubscription,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff9DB0C7)),
                            ),
                            Text(
                              "₹${state.price ?? '0'} / ${state.monthCount ?? 0} ${S.of(context).months}",
                              // "1099/4 months",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff9DB0C7)),
                            ),
                          ],
                        )
                      ],
                    ))
              ]),
              // AppPrimaryButton(
              //     fixedSize: Size(MediaQuery.of(context).size.width, 58),
              //     color: const Color(0xffEB6868),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(0)),
              //     // key: _buttonKey,
              //     onPressed: () {
              //       Get.dialog(
              //         const CancelDialog(),
              //         useSafeArea: true,
              //       );
              //     },
              //     child: Text(S.of(context).cancelSubscription))
            ],
          ),
          const Positioned(
              top: 20, child: AppBackButton(padding: EdgeInsets.zero)),
          Positioned(
              top: 65,
              left: 16,
              bottom: 0,
              right: 16,
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
                          if (controller.state!.subscription!.validTill != null)
                            Material(
                                borderRadius: BorderRadius.circular(15),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 5),
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          "${controller.state!.subscription!.validTill!.difference(DateTime.now()).inDays} ${S.of(context).days} ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff424242)),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: S.of(context).remaining,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff424242))),
                                      ],
                                    ),
                                  ),
                                ))
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
                                  controller.state?.avatar,
                                  radius: 58,
                                  name: controller.state?.name ?? "",
                                ),
                              ),
                            ),
                            Positioned(
                                right: 9,
                                left: 9,
                                bottom: -10,
                                child: Container(
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(11.5),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Color(0xffFF971E),
                                            Color(0xffFF8754),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          // stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 2, 7, 3),
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
                                                fontWeight: FontWeight.w400,
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
              )),
          Positioned(
            left: 16,
            right: 16,
            top: Get.height / 4 + 25,
            child: Container(
              padding: const EdgeInsets.all(2),
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
                        padding: const EdgeInsets.symmetric(vertical: 17),
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
                        text: S.of(context).rankAtTheTopInTheSearchResult),
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
                        text:
                            S.of(context).carrierTipsAndResumeBuildingHandbook),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
