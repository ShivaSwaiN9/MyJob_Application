import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/recent_looked_job_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';
import 'package:my_job_flutter/pages/dashboard/my_applications/my_applications_page.dart';
import 'package:my_job_flutter/pages/dashboard/profile/profile_page.dart';
import 'package:my_job_flutter/pages/dashboard/search/search_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/home/home_page.dart';

import '../../../global_controllers/user_controller.dart';
import '../../dashboard_for_org/controller/applied_widget_controller.dart';
import '../../dashboard_for_org/controller/completed_widget_controller.dart';
import 'author_controller.dart';
import 'banner_controller.dart';
import 'blog_controller.dart';
import 'companies_controller.dart';
import 'featured_job_controller.dart';

///
/// Created by Kumar Sunil from Boiler plate
///
class DashboardController extends GetxController {
  RxInt selectedIndex = RxInt(0);
  final GlobalKey<ScaffoldState> key = GlobalKey();
  late List pages;

  final PlanController subscriptionController;
  final ActiveControllerJobSeeker activeControllerjobSeeker;
  final AppliedWidgetController appliedWidgetController;
  final CompletedWidgetController completedWidgetController;
  final UserController userController;
  final AuthorController authorController;
  final FeaturedJobController featuredJobController;
  final BannerController bannerController;
  final CompaniesController companiesController;
  final BlogController blogController;
  final RecentLookedJobController recentLookedJobController;
  DashboardController(
      this.subscriptionController,
      this.activeControllerjobSeeker,
      this.appliedWidgetController,
      this.completedWidgetController,
      this.userController,
      this.authorController,
      this.featuredJobController,
      this.bannerController,
      this.companiesController,
      this.blogController,
      this.recentLookedJobController);

  @override
  void onInit() {
    pages = [
      HomePage(
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
          recentLookedJobController),
      const SearchPage(),
      const MyApplicationsPage(),
      const ProfilePage()
    ];
    super.onInit();
  }

  void onTap(int index) {
    selectedIndex.value = index;
  }
}
