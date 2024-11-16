import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/controller/requested_widget_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class RequestWidget extends StatefulWidget {
  const RequestWidget({Key? key}) : super(key: key);

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  late RequestedWidgetController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<RequestedWidgetController>();
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
                  controller.getEmployeeRequested();
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
                  controller.getEmployeeRequested();
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
