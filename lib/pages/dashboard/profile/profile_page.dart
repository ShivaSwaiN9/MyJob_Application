import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/widgets/enter_job_preference.dart';
import 'package:my_job_flutter/pages/cancel_subscription/cancel_subscription_page.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';
import 'package:my_job_flutter/pages/dashboard/my_applications/my_applications_page.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/education_details_sheet.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/education_list_tile.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/employement_details_sheet.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/employement_list_tile.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/personal_details_sheet.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/profile_expansion_tile.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/project_details_sheet.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/project_list_tile.dart';
import 'package:my_job_flutter/pages/dashboard/referral/referral_page.dart';
import 'package:my_job_flutter/pages/dashboard/widget/subscription_card.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserController controller;
  late PlanController subController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserController>();
    subController = Get.isRegistered<PlanController>()
        ? Get.find<PlanController>()
        : Get.put(PlanController());
  }

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
        color: Color(0xff9D9D9D), fontSize: 12, fontWeight: FontWeight.w400);
    const textStyle = TextStyle(
        color: Color(0xff2D2D2D), fontSize: 12, fontWeight: FontWeight.w500);
    // final subController = Get.find<SubscriptionController>();
    return Scaffold(
        backgroundColor: Colors.white,
        body: controller.obx(
          (state) {
            return state == null
                ? const Center(child: AppProgress())
                : RefreshIndicator(
                    onRefresh: controller.refreshUser,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 50,
                                child: state.coverImage == null ||
                                        state.coverImage!.isEmpty
                                    ? Image.asset(
                                        AppAssets.dashboardBackgroundImage,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        state.coverImage ?? '',
                                        fit: BoxFit.cover,
                                        width: Get.width,
                                      ),
                              ),
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
                                      GetBuilder<UserController>(
                                          init: controller,
                                          builder: (controller) {
                                            return IconButton(
                                                onPressed: () {
                                                  controller
                                                      .chooseCoverPicture();
                                                },
                                                icon: SvgPicture.asset(
                                                    AppAssets.edit));
                                          }),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: PopupMenuButton(
                                            tooltip:
                                                S.of(context).changeLanguage,
                                            itemBuilder: (context) {
                                              return [
                                                if (Intl.getCurrentLocale() ==
                                                    "or_IN")
                                                  const PopupMenuItem(
                                                    child: Text("English"),
                                                    value: 1,
                                                  ),
                                                if (Intl.getCurrentLocale() ==
                                                    "en")
                                                  const PopupMenuItem(
                                                    child: Text("Odia"),
                                                    value: 2,
                                                  ),
                                              ];
                                            },
                                            child: const Icon(Icons.language,
                                                color: Colors.white),
                                            onSelected: (i) {
                                              if (i == 1) {
                                                SharedPreferenceHelper
                                                    .storeLocale("en");
                                                S.load(const Locale("en"));
                                                Get.find<
                                                        GetMaterialController>()
                                                    .restartApp();
                                              }
                                              if (i == 2) {
                                                SharedPreferenceHelper
                                                    .storeLocale("or_IN");
                                                S.load(const Locale("or_IN"));
                                                Get.find<
                                                        GetMaterialController>()
                                                    .restartApp();
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
                                                if (state.subscription !=
                                                        null &&
                                                    state.subscription
                                                            ?.status ==
                                                        1)
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xffFFC01D),
                                                            Color(0xffFFDB1D),
                                                            Color(0xffFF6853),
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter),
                                                    ),
                                                    // type: MaterialType.circle,
                                                    // color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: Material(
                                                        type:
                                                            MaterialType.circle,
                                                        color: Colors.white,
                                                        child: UserCircleAvatar(
                                                          state.avatar,
                                                          radius: 58,
                                                          name:
                                                              state.name ?? "",
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                else
                                                  Material(
                                                    type: MaterialType.circle,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4),
                                                      child: UserCircleAvatar(
                                                        state.avatar,
                                                        radius: 58,
                                                        name: state.name ?? "",
                                                      ),
                                                    ),
                                                  ),
                                                if (controller.uploadingDp)
                                                  Positioned.fill(
                                                      child:
                                                          CircularProgressIndicator(
                                                              color: Get.theme
                                                                  .primaryColor)),
                                                Positioned(
                                                    right: -4,
                                                    bottom: -4,
                                                    child: Material(
                                                      color: Colors.white,
                                                      type: MaterialType.circle,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: state.subscription !=
                                                                          null &&
                                                                      state.subscription
                                                                              ?.status ==
                                                                          1
                                                                  ? const Color(
                                                                      0xffFFECBC)
                                                                  : const Color(
                                                                      0xffC6E3FE),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: SvgPicture.asset(
                                                                  AppAssets
                                                                      .image,
                                                                  color: state.subscription !=
                                                                              null &&
                                                                          state.subscription?.status ==
                                                                              1
                                                                      ? const Color(
                                                                          0xffFF7D54)
                                                                      : const Color(
                                                                          0xff319EFF),
                                                                  width: 18),
                                                            )),
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(22, 12, 22, 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.name ?? "",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              if (state.subscription != null &&
                                  state.subscription?.status == 1)
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(colors: [
                                          Color(0xffFF971E),
                                          Color(0xffFF8754)
                                        ])),
                                    child: SvgPicture.asset(AppAssets.done))
                            ],
                          ),
                        ),
                        if (state.bio!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                            child: Text(
                              state.bio ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff262626)),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 12.0,
                              lineWidth: 3.0,
                              percent: state.getPercentage() / 100,
                              progressColor: Get.theme.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                "${state.getPercentage().toStringAsFixed(0)}% ${S.of(context).complete}")
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (state.subscription == null ||
                            state.subscription?.status != 1)
                          subController.obx(
                              (state1) => SubscriptionCard(
                                    status: state.subscription?.status ?? 0,
                                    state: state1![0],
                                  ),
                              onLoading: const AppProgress(),
                              onEmpty: const SizedBox()),
                        if (state.subscription != null &&
                            state.subscription?.status == 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(CancelSubscriptionPage.routeName,
                                      arguments: {
                                        "planDatum": subController.state![0]
                                      });
                                },
                                child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffEAEAEA),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.1),
                                              blurRadius: 49,
                                              spreadRadius: -28,
                                              offset: const Offset(0, 27))
                                        ]),
                                    child: ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.only(top: 3),
                                        child: SvgPicture.asset(
                                          AppAssets.unionIcon,
                                          height: 19,
                                        ),
                                      ),
                                      title: Text(S.of(context).viewMembership),
                                    ))),
                          ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProfileExpansionTile(
                            leadingIcon: SvgPicture.asset(
                              AppAssets.profileVector,
                              width: 18,
                              color: Get.theme.primaryColor,
                            ),
                            title: S.of(context).personalDetails,
                            onEdit: () {
                              Get.bottomSheet(PersonalDetailsSheet(state),
                                  isScrollControlled: true);
                            },
                            children: [
                              Text(S.of(context).email, style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(state.email ?? '', style: textStyle),
                              const SizedBox(height: 10),
                              Text(S.of(context).gender, style: subTitleStyle),
                              const SizedBox(height: 5),
                              Text(state.genderString(context),
                                  style: textStyle),
                              Text(S.of(context).phoneNo, style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(state.phone ?? "", style: textStyle),
                              const SizedBox(height: 10),
                              Text(S.of(context).dateOfBirth,
                                  style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(
                                  state.dob == null
                                      ? ""
                                      : DateFormat("dd.MM.yyyy")
                                          .format(state.dob!),
                                  style: textStyle),
                              const SizedBox(height: 10),
                              Text(S.of(context).maritalStatus,
                                  style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(state.maritalStatusString(context),
                                  style: textStyle),
                              const SizedBox(height: 10),
                              Text(S.of(context).address, style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(
                                state.getAddressString(),
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProfileExpansionTile(
                            leadingIcon: SvgPicture.asset(
                              AppAssets.newEducation,
                              width: 22,
                              color: Get.theme.primaryColor,
                            ),
                            title: S.of(context).educationDetails,
                            onAdd: () {
                              Get.bottomSheet(const EducationDetailsSheet(),
                                  isScrollControlled: true);
                            },
                            children: state.education
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EducationListTile(education: e),
                                        const Divider()
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProfileExpansionTile(
                            leadingIcon: SvgPicture.asset(
                              AppAssets.newEmploymentIcon,
                              width: 22,
                              // color: Get.theme.primaryColor,
                            ),
                            title: S.of(context).employmentDetails,
                            onAdd: () {
                              Get.bottomSheet(const EmploymentDetailsSheet(),
                                  isScrollControlled: true);
                            },
                            children: state.employment
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EmploymentListTile(employment: e),
                                        const Divider()
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProfileExpansionTile(
                            leadingIcon: SvgPicture.asset(
                              AppAssets.myProject,
                              width: 22,
                              // color: Get.theme.primaryColor,
                            ),
                            title: 'My Projects',
                            onAdd: () {
                              Get.bottomSheet(const ProjectDetailsSheet(),
                                  isScrollControlled: true);
                            },
                            children: state.project
                                .map((e) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProjectListTile(e),
                                        const Divider()
                                      ],
                                    ))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ProfileExpansionTile(
                            leadingIcon: SvgPicture.asset(
                              AppAssets.newJobPrefers,
                              width: 22,
                              color: Get.theme.primaryColor,
                            ),
                            title: S.of(context).jobPreference,
                            onEdit: () {
                              Get.bottomSheet(EnterJobPreference(),
                                  isScrollControlled: true,
                                  ignoreSafeArea: false);
                            },
                            children: [
                              Text(S.of(context).primaryJobPreference,
                                  style: subTitleStyle),
                              const SizedBox(height: 5),
                              Text(
                                state.primaryJobPreference ?? "",
                                style: textStyle,
                              ),
                              const SizedBox(height: 10),
                              Text(S.of(context).secondaryJobPreference,
                                  style: subTitleStyle),
                              const SizedBox(height: 6),
                              Text(state.secondaryJobPreference ?? "",
                                  style: textStyle),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(MyApplicationsPage.routeName);
                              },
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: const Color(0xffEAEAEA),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.1),
                                            blurRadius: 49,
                                            spreadRadius: -28,
                                            offset: const Offset(0, 27))
                                      ]),
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: SvgPicture.asset(
                                        AppAssets.documentVector,
                                        color: Get.theme.primaryColor,
                                        height: 18,
                                      ),
                                    ),
                                    title: Text(S.of(context).myApplications),
                                  ))),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                              onTap: () {
                                Get.toNamed(ReferralPage.routeName,
                                    arguments: {"state": state.referralCode});
                              },
                              child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: const Color(0xffEAEAEA),
                                          width: 1),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.1),
                                            blurRadius: 49,
                                            spreadRadius: -28,
                                            offset: const Offset(0, 27))
                                      ]),
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: SvgPicture.asset(
                                        AppAssets.newReferralIcon,
                                        color: Get.theme.primaryColor,
                                        height: 18,
                                      ),
                                    ),
                                    title: Text(S.of(context).referralProgram),
                                  ))),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: TextButton(
                              onPressed: () {
                                showAppAlertDialog(
                                        title: S.of(context).logout,
                                        description: S
                                            .of(context)
                                            .areYouSureWantToLogout)
                                    .then((value) {
                                  if (value == true) {
                                    AuthHelper.logoutUser();
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: Text(S.of(context).logout)),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ));
          },
          onEmpty: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppAssets.pleaseLogin),
              const SizedBox(
                height: 32,
              ),
              Text(
                S.of(context).pleaseLoginToContinue,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              AppPrimaryButton(
                onPressed: () {
                  Get.toNamed(NewPhonePage.routeName,
                      arguments: {"isLoginFromStart": true});
                },
                child: Text(S.of(context).goToLogin),
              ).paddingOnly(left: 16, right: 16, bottom: 20)
            ],
          ),
          onLoading: const Center(child: AppProgress()),
        ));
  }
}
