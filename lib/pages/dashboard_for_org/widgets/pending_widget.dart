import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/pending_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({Key? key}) : super(key: key);

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
  late PendingWidgetController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PendingWidgetController());
  }

  @override
  void dispose() {
    Get.delete<PendingWidgetController>(force: true);
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
                  controller.getEmployeeRequestPending();
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  itemBuilder: (ctx, i) => RequestCard(
                    data: controller.state![i],
                  ),
                  itemCount: state!.length,
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
          onError: (e) => AppErrorWidget(
              title: e ?? 'Some error occurred',
              onRetry: () {
                controller.getEmployeeRequestPending();
              }),
          onEmpty:
              Center(child: SvgPicture.asset(AppAssets.dashboardEmptyVector)),
          // AppEmptyWidget(
          //   title: 'No request pending found',
          //   onReload: () {
          //     controller.getEmployeeRequestPending();
          //   },
          // ),
          onLoading: const Center(child: CircularProgressIndicator()),
        ));
  }
}
