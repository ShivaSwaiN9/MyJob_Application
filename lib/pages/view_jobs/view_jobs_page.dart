import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/pages/view_jobs/view_jobs_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

///
/// Created by Sisira Sahoo
/// On 27/04/22 6:09 PM
///

class ViewJobsPage extends StatefulWidget {
  static const routeName = "/viewJobs";
  const ViewJobsPage({Key? key}) : super(key: key);

  @override
  State<ViewJobsPage> createState() => _ViewJobsPageState();
}

class _ViewJobsPageState extends State<ViewJobsPage> {
  late ViewJobsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ViewJobsController());
  }

  @override
  void dispose() {
    Get.delete<ViewJobsController>(force: true);
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
                          controller.name,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Expanded(
            child: controller.obx(
              (state) {
                if (controller.status.isSuccess && controller.state != null) {
                  return RefreshIndicator(
                    onRefresh: () {
                      controller.getViewJobs();
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
                      controller.getViewJobs();
                    }),
              ),
              onEmpty: AppEmptyWidget(
                title: S.of(context).noJobsFound,
                onReload: () {
                  controller.getViewJobs();
                },
              ),
              onLoading: const Center(child: AppProgress()),
            ),
          ),
        ],
      ),
    );
  }
}
