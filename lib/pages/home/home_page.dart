import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/employee_request_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/Featured_job/featured_job_page.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/author_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/banner_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/blog_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/companies_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/featured_job_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/recent_looked_job_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';
import 'package:my_job_flutter/pages/dashboard/recommended_jobs/recommended_jobs_page.dart';
import 'package:my_job_flutter/pages/dashboard/widget/blog_widget.dart';
import 'package:my_job_flutter/pages/dashboard/widget/companies_card.dart';
import 'package:my_job_flutter/pages/dashboard/widget/dashboard_sliver_header.dart';
import 'package:my_job_flutter/pages/dashboard/widget/subscription_card.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/applied_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/completed_widget_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_detail_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Created by Sisira Sahoo
/// On 02/04/22 12:07 PM
///

class HomePage extends StatelessWidget {
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
  const HomePage(
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
      this.recentLookedJobController,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: DashboardSliverPersistentHeader(
                expandedHeight: 300,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  userController.obx((state) {
                    if(state == null){
                      return const SizedBox();
                    }else {
                      if (state.subscription == null) {
                        return subscriptionController.obx(
                                (state) =>
                                SubscriptionCard(
                                  state: state![0],
                                  status: 0,
                                ),
                            onLoading: const AppProgress(),
                            onEmpty: const SizedBox());
                      } else {
                        return state.subscription?.status == 0
                            ? subscriptionController.obx(
                                (state) =>
                                SubscriptionCard(
                                  state: state![0],
                                  status: 0,
                                ),
                            onLoading: const AppProgress(),
                            onEmpty: const SizedBox())
                            : state.subscription?.status == -2
                            ? subscriptionController.obx(
                                (state) =>
                                SubscriptionCard(
                                  status: -2,
                                  state: state![0],
                                ),
                            onLoading: const AppProgress(),
                            onEmpty: const SizedBox())
                            : state.subscription?.status == -1
                            ? subscriptionController.obx(
                                (state) =>
                                SubscriptionCard(
                                  status: -1,
                                  state: state![0],
                                ),
                            onLoading: const AppProgress(),
                            onEmpty: const SizedBox())
                            : const SizedBox();
                      }
                    }
                  }, onLoading: const SizedBox(), onEmpty: const SizedBox()),
                  // subscriptionController.obx(
                  //     (state) => SubscriptionCard(
                  //           state: state![0],
                  //         ),
                  //     onLoading: const SizedBox(),
                  //     onEmpty: const SizedBox()),
                  bannerController.obx(
                    (state) => CarouselSlider(
                      options: CarouselOptions(
                        height: 150,
                        viewportFraction: 0.8, aspectRatio: 16 / 9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        // reverse: true,
                        autoPlay: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: state?.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: GestureDetector(
                            onTap: () {
                              if (e.entityType == 1) {
                                Get.toNamed(
                                    DashboardForOrgPage.routeName +
                                        RequestDetailPage.routeName,
                                    arguments: {"requestDatum": e.entityId});
                              } else if (e.entityType == 2) {
                                launch(e.entityId!);
                              }
                            },
                            child: Material(
                                clipBehavior: Clip.antiAlias,
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  e.image ?? '',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )),
                          ),
                        );
                      }).toList(),
                    ),
                    onLoading: const SizedBox(),
                    onEmpty: const SizedBox(),
                  ),
                  const SizedBox(height: 40),
                  featuredJobController.obx(
                          (state) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        color: const Color(0xffDCEFFF),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  S.of(context).featuredJobs,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 19,
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xffEB6868),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8, 3, 8, 3),
                                    child: Text(
                                      '${state!.length} ' +
                                          S.of(context).newValue,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(FeaturedJobPage.routeName);
                                  },
                                  child: Text(
                                    S.of(context).viewAll,
                                    style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              S.of(context).basedOnYourProfile,
                              style: const TextStyle(
                                  color: Color(0xff545454), fontSize: 12),
                            ),
                            const SizedBox(height: 18),
                            SizedBox(
                              height: 150,
                              child: GridView.builder(
                                // shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount:
                                state.length < 10 ? state.length : 10,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 0.60,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return FeaturedJobCard(
                                    state: state[index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      onLoading: const SizedBox(),
                      onEmpty: const SizedBox()),
                  const SizedBox(
                    height: 40,
                  ),
                  if(SharedPreferenceHelper.user?.accessToken != null)
                  activeControllerjobSeeker.obx(
                      (state) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).recommendedJobs,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff000000),
                                          fontSize: 16),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            RecommendedJobsPage.routeName);
                                      },
                                      child: Text(
                                        S.of(context).viewAll,
                                        style: TextStyle(
                                            color: Get.theme.primaryColor,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  S.of(context).basedOnYourProfile,
                                  style: const TextStyle(
                                      color: Color(0xff545454), fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        state!.length < 10 ? state.length : 10,
                                    itemBuilder: (ctx, i) =>
                                        RequestCard(data: state[i])),
                                // const SizedBox(
                                //   height: 0,
                                // ),
                              ],
                            ),
                          ),
                      onEmpty: const SizedBox(),
                      onLoading: const SizedBox()),
                  companiesController.obx(
                      (state) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).topCompanies,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                SizedBox(
                                  height: 250,
                                  child: GridView.builder(
                                    // shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        state!.length < 10 ? state.length : 10,
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: 1.5,
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return CompaniesCard(
                                        state: state[index],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                      onEmpty: const SizedBox(),
                      onLoading: const SizedBox()),
                  recentLookedJobController.obx((state) {
                    if (state!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  S.of(context).recentlyLookedJobs,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff000000),
                                      fontSize: 16),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(FeaturedJobPage.routeName);
                                  },
                                  child: Text(
                                    S.of(context).viewAll,
                                    style: TextStyle(
                                        color: Get.theme.primaryColor,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                              height: 195,
                              child: GridView.builder(
                                // shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.length,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 0.60,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return RequestCard(data: state[index]);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  }, onEmpty: const SizedBox(), onLoading: const SizedBox()),
                  blogController.obx(
                    (state) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).ourBlogs,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff000000),
                                fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          ListView.separated(
                            separatorBuilder: (ctx, i) => const SizedBox(
                              height: 20,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return BlogWidget(state: state[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                    onEmpty: const SizedBox(),
                    onLoading: const SizedBox(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  authorController.obx(
                    (state) => Stack(
                      children: [
                        SvgPicture.asset(
                          AppAssets.dashboardBottomBanner,
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: Get.height / 3,
                        ),
                        Column(
                          children: [
                            if (state![0].image!.isNotEmpty)
                              Image.network(
                                state[0].image ?? '',
                                fit: BoxFit.cover,
                                width: Get.width,
                              ),
                            const SizedBox(
                              height: 36,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              child: Text(
                                state[0].quote ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 12,
                                    fontFamily: Environment.fontFamily,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Text(
                              "-${state[0].author ?? ''}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: Environment.fontFamily,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onEmpty: const SizedBox(),
                    onLoading: const SizedBox(),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class FeaturedJobCard extends StatelessWidget {
  final EmployeeRequestDatum state;
  const FeaturedJobCard({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(DashboardForOrgPage.routeName + RequestDetailPage.routeName,
            arguments: {"requestDatum": state.id});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 25),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      state.title ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                          color: Color(0xff545454),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(AppAssets.bookmarkIcon)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.locationVector),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '${state.workLocation}',
                    style: const TextStyle(
                      color: Color(0xff545454),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  SvgPicture.asset(AppAssets.walletVector),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '₹ ${state.salary} ${S.of(context).months}',
                    style: const TextStyle(
                      color: Color(0xff545454),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
