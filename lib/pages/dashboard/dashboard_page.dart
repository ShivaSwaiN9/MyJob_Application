import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/dashboard_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';

import '../../global_controllers/user_controller.dart';
import '../dashboard_for_org/controller/active_widget_controller.dart';
import '../dashboard_for_org/controller/applied_widget_controller.dart';
import '../dashboard_for_org/controller/completed_widget_controller.dart';
import 'controllers/author_controller.dart';
import 'controllers/banner_controller.dart';
import 'controllers/blog_controller.dart';
import 'controllers/companies_controller.dart';
import 'controllers/featured_job_controller.dart';
import 'controllers/recent_looked_job_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///

class DashboardPage extends StatefulWidget {
  static const routeName = '/';
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardController controller;
  late PlanController subscriptionController;
  late ActiveControllerJobSeeker activeControllerjobSeeker;
  late AppliedWidgetController appliedWidgetController;
  late CompletedWidgetController completedWidgetController;
  late UserController userController;
  late AuthorController authorController;
  late FeaturedJobController featuredJobController;
  late BannerController bannerController;
  late CompaniesController companiesController;
  late BlogController blogController;
  late RecentLookedJobController recentLookedJobController;
  @override
  void initState() {
    super.initState();
    subscriptionController = Get.isRegistered<PlanController>()
        ? Get.find<PlanController>()
        : Get.put(PlanController());
    activeControllerjobSeeker = Get.isRegistered<ActiveControllerJobSeeker>()
        ? Get.find<ActiveControllerJobSeeker>()
        : Get.put(ActiveControllerJobSeeker());
    appliedWidgetController = Get.isRegistered<AppliedWidgetController>()
        ? Get.find<AppliedWidgetController>()
        : Get.put(AppliedWidgetController());
    completedWidgetController = Get.isRegistered<CompletedWidgetController>()
        ? Get.find<CompletedWidgetController>()
        : Get.put(CompletedWidgetController());
    userController = Get.isRegistered<UserController>()
        ? Get.find<UserController>()
        : Get.put(UserController());
    authorController = Get.isRegistered<AuthorController>()
        ? Get.find<AuthorController>()
        : Get.put(AuthorController());
    featuredJobController = Get.isRegistered<FeaturedJobController>()
        ? Get.find<FeaturedJobController>()
        : Get.put(FeaturedJobController());
    bannerController = Get.isRegistered<BannerController>()
        ? Get.find<BannerController>()
        : Get.put(BannerController());
    companiesController = Get.isRegistered<CompaniesController>()
        ? Get.find<CompaniesController>()
        : Get.put(CompaniesController());
    blogController = Get.isRegistered<BlogController>()
        ? Get.find<BlogController>()
        : Get.put(BlogController());
    recentLookedJobController = Get.isRegistered<RecentLookedJobController>()
        ? Get.find<RecentLookedJobController>()
        : Get.put(RecentLookedJobController());
    controller = Get.put(DashboardController(
        subscriptionController,
        activeControllerjobSeeker,
        appliedWidgetController,
        completedWidgetController,
        userController,
        authorController,
        featuredJobController,
        bannerController,
        companiesController,
        blogController,
        recentLookedJobController));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value == 0)
          return true;
        else {
          setState(() {
            controller.selectedIndex.value = 0;
          });
          return false;
        }
      },
      child: Obx(
        () => Scaffold(
          key: controller.key,
          backgroundColor: const Color(0xffFFFFFF),
          body: controller.pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              selectedItemColor: AppColors.brightPrimary,
              onTap: controller.onTap,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.homeIcon,
                      color: AppColors.brightPrimary,
                    ),
                    icon: SvgPicture.asset(AppAssets.homeIcon,
                        color: const Color(0xffBCBCBC)),
                    backgroundColor: Colors.white,
                    label: S.of(context).home),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.bottomSearch,
                      color: AppColors.brightPrimary,
                    ),
                    icon: SvgPicture.asset(AppAssets.bottomSearch,
                        color: const Color(0xffBCBCBC)),
                    label: S.of(context).search),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.documentVector,
                      color: AppColors.brightPrimary,
                    ),
                    icon: SvgPicture.asset(AppAssets.documentVector,
                        color: const Color(0xffBCBCBC)),
                    label: S.of(context).applications),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      AppAssets.profileVector,
                      color: AppColors.brightPrimary,
                    ),
                    icon: SvgPicture.asset(AppAssets.profileVector,
                        color: const Color(0xffBCBCBC)),
                    label: S.of(context).profile)
              ]),
        ),
      ),
    );
  }
}
