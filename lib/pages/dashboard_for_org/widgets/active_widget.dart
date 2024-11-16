import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/active_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class ActiveWidget extends StatefulWidget {
  const ActiveWidget({Key? key}) : super(key: key);

  @override
  State<ActiveWidget> createState() => _ActiveWidgetState();
}

class _ActiveWidgetState extends State<ActiveWidget> {
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
        child: controller.obx(
      (state) {
        if (controller.status.isSuccess && controller.state != null) {
          return RefreshIndicator(
            onRefresh: () {
              controller.getEmployeeRequestActive();
              return Future.delayed(const Duration(seconds: 2));
            },
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
              controller.getEmployeeRequestActive();
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
      onLoading: const Padding(
        padding: EdgeInsets.all(32),
        child: const Center(child: AppProgress()),
      ),
    ));
  }
}
