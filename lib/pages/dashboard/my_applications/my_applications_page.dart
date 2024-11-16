import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_page.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/my_app_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class MyApplicationsPage extends StatefulWidget {
  static const routeName = '/my_applications';

  const MyApplicationsPage({Key? key}) : super(key: key);

  @override
  State<MyApplicationsPage> createState() => _MyApplicationsPageState();
}

class _MyApplicationsPageState extends State<MyApplicationsPage> {
  late MyApplicationController controller;
  late UserController userController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MyApplicationController());
    userController = Get.find<UserController>();
  }

  @override
  void dispose() {
    Get.delete<MyApplicationController>(force: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Image.asset(
                    AppAssets.searchBackgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: 2,
                    // right: 0,
                    bottom: 25,
                    // top: 50,
                    child: Row(
                      children: [
                        const AppBackButton(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        Text(
                          S.of(context).myApplications,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Expanded(
            child: userController.obx(
              (userState) {
                if (userState != null) {
                  controller.obx(
                    (state) {
                      if (controller.status.isSuccess &&
                          controller.state != null) {
                        return RefreshIndicator(
                          onRefresh: () {
                            controller.getAllJobs();
                            return Future.delayed(const Duration(seconds: 2));
                          },
                          child: ListView.builder(
                            controller: controller.scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            // shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            itemBuilder: (ctx, i) => RequestCard(
                              data: controller.state![i],
                            ),
                            itemCount: state!.length,
                          ),
                        );
                      }
                      return const Center(child: AppProgress());
                    },
                    onError: (e) => Padding(
                      padding: const EdgeInsets.all(32),
                      child: AppErrorWidget(
                          title: e ?? S.of(context).someErrorOccurred,
                          onRetry: () {
                            controller.getAllJobs();
                          }),
                    ),
                    onEmpty: AppEmptyWidget(
                      title: S.of(context).noJobsFound,
                      onReload: () {
                        controller.getAllJobs();
                      },
                    ),
                    onLoading: const Center(child: AppProgress()),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.noJobs),
                    const SizedBox(height: 32,),
                    Text(
                      S.of(context).noJobsFound,
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                );
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
            ),
          ),
        ],
      ),
    );
  }
}
