import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/active_widget_for_org.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/completed_widget_for_org.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/requested_org_widget.dart';
import 'controller/active_widget_controller.dart';
import 'controller/completed_widget_for_org_controller.dart';
import 'controller/requested_widget_controller.dart';
import 'widgets/org_dashboard_sliver_header.dart';

class DashboardForOrgPage extends StatefulWidget {
  static const routeName = '/DashboardForOrgPage';
  const DashboardForOrgPage({Key? key}) : super(key: key);

  @override
  State<DashboardForOrgPage> createState() => _DashboardForOrgPageState();
}

class _DashboardForOrgPageState extends State<DashboardForOrgPage>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  late RequestedWidgetController requestedWidgetController;
  late ActiveControllerJobSeeker activeControllerOrg;
  late CompletedWidgetForOrgController widgetForOrgController;
  late UserController userController;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    requestedWidgetController = Get.put(RequestedWidgetController());
    activeControllerOrg = Get.put(ActiveControllerJobSeeker());
    widgetForOrgController = Get.put(CompletedWidgetForOrgController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<RequestedWidgetController>(force: true);
    Get.delete<ActiveControllerJobSeeker>(force: true);
    Get.delete<CompletedWidgetForOrgController>(force: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        body: DefaultTabController(
          length: 3,
          child: RefreshIndicator(
            onRefresh: () {
              currentPage == 0
                  ? requestedWidgetController.getEmployeeRequested()
                  : currentPage == 1
                      ? activeControllerOrg.getEmployeeRequestActive()
                      : widgetForOrgController.getCompletedLists();
              return Future.delayed(const Duration(microseconds: 2));
            },
            child: CustomScrollView(
                controller: currentPage == 0
                    ? requestedWidgetController.scrollController
                    : currentPage == 1
                        ? activeControllerOrg.scrollController
                        : widgetForOrgController.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: OrgDashboardSliverPersistentTab(
                          controller: userController,
                          expandedHeight: 310,
                          currentIndex: currentPage,
                          onChanged: (i) {
                            setState(() {
                              currentPage = i;
                            });
                            currentPage == 0
                                ? requestedWidgetController
                                    .getEmployeeRequested()
                                : currentPage == 1
                                    ? activeControllerOrg
                                        .getEmployeeRequestActive()
                                    : widgetForOrgController
                                        .getCompletedLists();
                          })),
                  SliverToBoxAdapter(
                      child: [
                    const RequestWidget(),
                    const ActiveWidgetForOrg(),
                    const CompletedWidgetForOrg()
                  ][currentPage]),
                ]),
          ),
        ));
  }
}
