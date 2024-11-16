import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/featured_job_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

import '../../home/home_page.dart';

class FeaturedJobPage extends GetView<FeaturedJobController> {
  static const routeName = '/featuredJob';
  const FeaturedJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const AppBackButton(),
        backgroundColor: Colors.transparent,
        title: Text(S.of(context).featuredJobs),
        titleSpacing: 0,
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: Environment.fontFamily,
            fontWeight: FontWeight.w500),
      ),
      body: controller.obx(
        (state) {
          if (controller.status.isSuccess && controller.state != null) {
            return RefreshIndicator(
              onRefresh: () {
                controller.getFeaturedJobs();
                return Future.delayed(const Duration(seconds: 2));
              },
              child: ListView.builder(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                itemBuilder: (ctx, i) => Column(
                  children: [
                    FeaturedJobCard(
                      state: controller.state![i],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
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
                controller.getFeaturedJobs();
              }),
        ),
        onEmpty: Center(
            child: Padding(
          padding: const EdgeInsets.all(32),
          child: SvgPicture.asset(AppAssets.dashboardEmptyVector),
        )),
        // AppEmptyWidget(
        //   title: 'No request applied found',
        //   onReload: () {
        //     controller.getEmployeeRequestApplied();
        //   },
        // ),
        onLoading: const Center(child: AppProgress()),
      ),
    );
  }
}
