import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';
import 'package:my_job_flutter/pages/dashboard/widget/subscription_card.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/org_profile/edit_org_profile_sheet.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';
import 'package:url_launcher/url_launcher.dart';

class OrgProfile extends StatefulWidget {
  static const routeName = '/orgProfile';
  const OrgProfile({Key? key}) : super(key: key);

  @override
  State<OrgProfile> createState() => _OrgProfileState();
}

class _OrgProfileState extends State<OrgProfile> {
  late UserController controller;
  late PlanController planController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<UserController>();
    planController = Get.isRegistered()
        ? Get.find<PlanController>()
        : Get.put(PlanController());
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.refreshUser();
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      Container(
                        color: Colors.red,
                        height: 170,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                height: 170,
                                child: SvgPicture.asset(
                                  AppAssets.profilePageVector,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                )),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              height: 170,
                              child: ColoredBox(
                                color:
                                    const Color(0xff113767).withOpacity(0.65),
                              ),
                            ),
                            // Positioned(
                            //     right: 16,
                            //     top: 0,
                            //     child: SafeArea(
                            //       child: TextButton(
                            //         child: Text("Edit profile"),
                            //         onPressed: () {
                            //           Get.bottomSheet(EditProfileSheet(state!),
                            //               isScrollControlled: true,
                            //               backgroundColor:
                            //                   Get.theme.scaffoldBackgroundColor);
                            //         },
                            //         style: TextButton.styleFrom(
                            //             padding:
                            //                 const EdgeInsets.fromLTRB(14, 0, 14, 0),
                            //             shape: const StadiumBorder(),
                            //             backgroundColor: const Color(0xcc406fe9),
                            //             primary: Colors.white),
                            //       ),
                            //     )),
                            SafeArea(
                              child: Row(
                                children: [
                                  const AppBackButton(
                                    color: Colors.white,
                                  ),
                                  const Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: Environment.fontFamily),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(const EditProfileSheet(),
                                          isScrollControlled: true,
                                          backgroundColor: Get
                                              .theme.scaffoldBackgroundColor);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.edit),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontFamily:
                                                  Environment.fontFamily),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: -150,
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
                                        Material(
                                          type: MaterialType.circle,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4),
                                            child: UserCircleAvatar(
                                                state.avatar,
                                                radius: 58),
                                          ),
                                        ),
                                        if (controller.uploadingDp)
                                          const Positioned.fill(
                                              child:
                                                  CircularProgressIndicator()),
                                        Positioned(
                                            right: -3,
                                            bottom: -3,
                                            child: Material(
                                                color: Colors.white,
                                                type: MaterialType.circle,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: SvgPicture.asset(
                                                      AppAssets.image,
                                                      color: Get
                                                          .theme.primaryColor,
                                                      width: 18),
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                      Text(
                        "${state.companyName}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Material(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color(0xffEFF8FF),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(23, 18, 23, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: LinearProgressIndicator(
                                    value: state.progress(),
                                    minHeight: 6,
                                    backgroundColor: const Color(0xFFC7DFFF),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Your profile is ${(state.progress() * 100).truncate()}% complete',
                                  style:
                                      const TextStyle(color: Color(0xff545454)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      planController.obx(
                          (state1) => SubscriptionCard(
                                status: state.subscription?.status ?? 0,
                                state: state1![1],
                              ),
                          onLoading: const AppProgress(),
                          onEmpty: const SizedBox()),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email ID",
                              style: TextStyle(
                                  color: Color(0xffBCBCBC), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${state.email}",
                              style: const TextStyle(color: Color(0xff545454)),
                            ),
                            const Divider(
                              height: 20,
                            ),
                            const Text(
                              "Mobile no.",
                              style: TextStyle(
                                  color: Color(0xffBCBCBC), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${state.phone}",
                              style: const TextStyle(color: Color(0xff545454)),
                            ),
                            const Divider(
                              height: 20,
                            ),
                            const Text(
                              "Your name",
                              style: TextStyle(
                                  color: Color(0xffBCBCBC), fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${state.name}",
                              style: const TextStyle(color: Color(0xff545454)),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 26, 16, 40),
                        color: const Color(0xffE5F2FF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Upload Certificates',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            UploadCertificateTile(
                              state.document?.companyGstCertificate,
                              title: 'GST Certificate',
                              subTitle:
                                  state.document?.companyGstCertificate ?? "",
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller.deleteCertificate(
                                        "companyGSTCertificate");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile1(),
                              isUploading: controller.uploadingFile1,
                              onFileViewTap: () {
                                launch(state.document!.companyGstCertificate!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            UploadCertificateTile(
                              state.document?.companyPanCard,
                              title: 'PAN Card',
                              subTitle: 'Created 14 February 2022',
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller
                                        .deleteCertificate("companyPanCard");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile2(),
                              isUploading: controller.uploadingFile2,
                              onFileViewTap: () {
                                print('dgdg');
                                launch(state.document!.companyPanCard!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            UploadCertificateTile(
                              state.document?.fssaiLicense,
                              title: 'FSSAI License',
                              subTitle: 'Created 14 February 2022',
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller
                                        .deleteCertificate("FSSAILicense");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile3(),
                              isUploading: controller.uploadingFile3,
                              onFileViewTap: () {
                                launch(state.document!.fssaiLicense!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            UploadCertificateTile(
                              state.document?.companyIncorporationCertificate,
                              title: 'Company Incorp. Certificate',
                              subTitle: '',
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller.deleteCertificate(
                                        "companyIncorporationCertificate");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile4(),
                              isUploading: controller.uploadingFile4,
                              onFileViewTap: () {
                                launch(state.document!
                                    .companyIncorporationCertificate!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            UploadCertificateTile(
                              state.document?.shopAndEstablishmentCertificate,
                              title: 'Shop & establishment certi...',
                              subTitle: '',
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller.deleteCertificate(
                                        "shopAndEstablishmentCertificate");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile5(),
                              isUploading: controller.uploadingFile5,
                              onFileViewTap: () {
                                launch(state.document!
                                    .shopAndEstablishmentCertificate!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            UploadCertificateTile(
                              state.document?.msmeRegistrationCertification,
                              title: 'MSME registration certifcate',
                              subTitle: state.document
                                      ?.msmeRegistrationCertification ??
                                  "",
                              onDelete: () {
                                showAppAlertDialog(
                                        title: 'Delete?',
                                        description:
                                            "Are you sure want to delete?")
                                    .then((value) {
                                  if (value == true) {
                                    controller.deleteCertificate(
                                        "msmeRegistrationCertification");
                                  }
                                });
                              },
                              onUpload: () => controller.chooseFile6(),
                              isUploading: controller.uploadingFile6,
                              onFileViewTap: () {
                                launch(state
                                    .document!.msmeRegistrationCertification!);
                              },
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () {
                                    showAppAlertDialog(
                                            title: 'Logout?',
                                            description:
                                                "Are you sure want to logout?")
                                        .then((value) {
                                      if (value == true) {
                                        AuthHelper.logoutUser();
                                      }
                                    });
                                  },
                                  child: const Text("Logout?")),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
        onLoading: const Center(child: AppProgress()),
      ),
    );
  }
}

class UploadCertificateTile extends StatelessWidget {
  final String? document;
  final bool isUploading;
  final String subTitle;
  final String title;
  final VoidCallback onUpload;
  final VoidCallback onDelete;
  final VoidCallback onFileViewTap;

  const UploadCertificateTile(
    this.document, {
    Key? key,
    required this.isUploading,
    required this.subTitle,
    required this.title,
    required this.onUpload,
    required this.onDelete,
    required this.onFileViewTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Row(
      children: [
        GestureDetector(
          onTap: isUploading ? null : onUpload,
          child: Container(
            height: 60,
            width: 69,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(3),
                topLeft: Radius.circular(16),
                bottomRight: Radius.circular(3),
                bottomLeft: Radius.circular(16),
              ),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.documentVector,
                  color: document != null
                      ? isUploading
                          ? primary
                          : const Color(0xffA5A9BA)
                      : const Color(0xffF1655C),
                ),
                Text(
                  document != null
                      ? isUploading
                          ? "Uploading"
                          : 'Uploaded'
                      : 'Upload',
                  style: TextStyle(
                    fontSize: 10,
                    color: document != null
                        ? isUploading
                            ? primary
                            : const Color(0xffA5A9BA)
                        : const Color(0xffF1655C),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Expanded(
          child: InkWell(
            onTap: isUploading ? null : onFileViewTap,
            child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(3),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(3),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff000000),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            document != null
                                ? isUploading
                                    ? "Uploading"
                                    : "Uploaded"
                                : 'Not Uploaded',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xffAEAEAE),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (document != null)
                      GestureDetector(
                          onTap: isUploading ? null : onDelete,
                          child: SvgPicture.asset(
                            AppAssets.deleteIcon,
                            color: const Color(0xffA5A9BA),
                          ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
