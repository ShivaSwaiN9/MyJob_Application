import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class ActiveWidgetForOrg extends StatefulWidget {
  const ActiveWidgetForOrg({Key? key}) : super(key: key);

  @override
  State<ActiveWidgetForOrg> createState() => _ActiveWidgetForOrgState();
}

class _ActiveWidgetForOrgState extends State<ActiveWidgetForOrg> {
  late ActiveControllerJobSeeker controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ActiveControllerJobSeeker>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffFFFFFF),
        child: controller.obx(
          (state) {
            if (controller.status.isSuccess && controller.state != null) {
              return RefreshIndicator(
                onRefresh: () {
                  controller.getEmployeeRequestActive();
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemBuilder: (ctx, i) => RequestCard(
                    data: controller.state![i],
                  ),
                  itemCount: state!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              );
            }
            return const Center(child: AppProgress());
          },
          onError: (e) => Padding(
            padding: const EdgeInsets.all(32),
            child: AppErrorWidget(
                title: e ?? 'Some error occurred',
                onRetry: () {
                  controller.getEmployeeRequestActive();
                }),
          ),
          onEmpty: Padding(
            padding: const EdgeInsets.all(32),
            child:
                Center(child: SvgPicture.asset(AppAssets.dashboardEmptyVector)),
          ),
          // AppEmptyWidget(
          //   title: 'No request applied found',
          //   onReload: () {
          //     controller.getEmployeeRequestApplied();
          //   },
          // ),
          onLoading: Padding(
            padding: const EdgeInsets.all(32),
            child: const Center(child: AppProgress()),
          ),
        ));
  }
}
