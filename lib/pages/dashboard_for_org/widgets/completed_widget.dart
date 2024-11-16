import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/completed_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({Key? key}) : super(key: key);

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  late CompletedWidgetController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<CompletedWidgetController>();
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
                  controller.getEmployeeRequestCompleted();
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
          onError: (e) => Padding(
            padding: const EdgeInsets.all(32),
            child: AppErrorWidget(
                title: e ?? S.of(context).someErrorOccurred,
                onRetry: () {
                  controller.getEmployeeRequestCompleted();
                }),
          ),
          onEmpty: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: SvgPicture.asset(AppAssets.dashboardEmptyVector),
            ),
          ),
          onLoading: const Padding(
              padding: EdgeInsets.all(32), child: Center(child: AppProgress())),
        ));
  }
}
