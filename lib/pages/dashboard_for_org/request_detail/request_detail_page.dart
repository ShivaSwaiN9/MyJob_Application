import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_details_controller.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/widgets/request_details_tile.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:html2md/html2md.dart' as html2md;

class RequestDetailPage extends StatefulWidget {
  static const routeName = '/requestDetailPage';

  const RequestDetailPage({Key? key}) : super(key: key);

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  late RequestDetailsController controller;
  late UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    controller = Get.put(RequestDetailsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        leading: const AppBackButton(),
        title: Text('Job details'),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
        actions: [
          userController.obx((userState) {
            if (userState != null && userState.role == 3) {
              return IconButton(
                  onPressed: () {
                    controller.deleteRequest();
                  },
                  icon: const Icon(Icons.delete));
            } else {
              return controller.obx(
                (state) => Padding(
                  padding:
                      const EdgeInsets.only(right: 16, top: 15, bottom: 18),
                  child: Material(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(state?.applicationStatus == 0
                        ? 0xffC6E3FE
                        : state?.applicationStatus == 2
                            ? 0xffD3F0C1
                            : state?.applicationStatus == 1
                                ? 0xffFFE0B2
                                : state?.applicationStatus == 3
                                    ? 0xffFFEBEE
                                    : 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: Text(
                        state?.applicationStatus == 0
                            ? 'Active'
                            : state?.applicationStatus == 1
                                ? 'Applied'
                                : state?.applicationStatus == 2
                                    ? 'Accepted'
                                    : state?.applicationStatus == 3
                                        ? 'Rejected'
                                        : '',
                        style: TextStyle(
                            color: Color(state?.applicationStatus == 0
                                ? 0xff268AFF
                                : state?.applicationStatus == 2
                                    ? 0xff609C3B
                                    : state?.applicationStatus == 1
                                        ? 0xffFF9800
                                        : state?.applicationStatus == 3
                                            ? 0xFFF44336
                                            : 0),
                            fontSize: 12),
                      ),
                    ),
                  ),
                ),
                onLoading: const SizedBox(),
                onEmpty: const SizedBox(),
              );
            }
          },
              onLoading: Padding(
                padding: const EdgeInsets.only(right: 16, top: 15, bottom: 18),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffC6E3FE),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Text(
                      'Active',
                      style: TextStyle(color: Color(0xff268AFF), fontSize: 12),
                    ),
                  ),
                ),
              ),
              onEmpty: Padding(
                padding: const EdgeInsets.only(right: 16, top: 15, bottom: 18),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xffC6E3FE),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Text(
                      'Active',
                      style: TextStyle(color: Color(0xff268AFF), fontSize: 12),
                    ),
                  ),
                ),
              ),
              onError: (e) => const SizedBox()),
        ],
      ),
      body: SafeArea(
        child: controller.obx(
          (state) {
            return Container(
              color: Colors.white,
              child: RefreshIndicator(
                onRefresh: controller.getJobDetails,
                child: ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 25,
                        child: SvgPicture.asset(
                          AppAssets.companyNameIcon,
                          height: 30,
                        ),
                      ),
                      title: Text(
                        '${state?.title}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: Environment.fontFamily),
                      ),
                    ),
                    const Divider(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: RequestDetailsWidget(
                                asset: AppAssets.walletVector,
                                title: 'Salary',
                                desc: '₹${state?.salary ?? ''}',
                              ),
                            ),
                            Expanded(
                              child: RequestDetailsWidget(
                                asset: AppAssets.openingVector,
                                title: 'Opening',
                                desc: "${state?.noOfEmployees ?? ''} Posts",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RequestDetailsWidget(
                          asset: AppAssets.workVector,
                          title: 'Experience',
                          desc: "${state?.experience} Years",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RequestDetailsWidget(
                            asset: AppAssets.locationVector,
                            title: 'Location',
                            desc: (state?.workLocation ?? '')),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    const Divider(
                      height: 0,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(color: Color(0xffBCBCBC), fontSize: 12),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Markdown(
                      data: html2md.convert(state!.description!),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
                    const Divider(),
                    RequestDetailsTile(
                      title: 'Manpower type',
                      desc: state.type == 1
                          ? 'On pay roll'
                          : state.type == 2
                              ? 'Off pay roll'
                              : state.type == 3
                                  ? 'Direct recruitment'
                                  : '',
                    ),
                    // RequestDetailsTile(
                    //     title: 'Application applied', desc: '${state?.}'),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            );
          },
          onError: (e) => AppErrorWidget(
              title: e ?? 'Some error occurred',
              onRetry: () {
                controller.getJobDetails();
              }),
          onEmpty: AppEmptyWidget(
            title: 'No Job found',
            onReload: () {
              controller.getJobDetails();
            },
          ),
          onLoading: const Center(child: SizedBox()),
        ),
      ),
      floatingActionButton: userController.obx((userState) {
        return controller.obx(
          (state) => state == null
              ? getAction()
              : userState!.role == 1 && state.applicationStatus == 0
                  ? getAction()
                  : const SizedBox(),
          onEmpty: getAction(),
        );
      },
          onLoading: getAction(),
          onEmpty: getAction(),
          onError: (e) => const SizedBox()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget getAction() {
    return InkWell(
      onTap: controller.applyNow,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: Get.theme.primaryColor,
        child: const Center(
            child: Text(
          'Apply now',
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}

class RequestDetailsWidget extends StatelessWidget {
  final String asset, title, desc;

  const RequestDetailsWidget(
      {Key? key, required this.asset, required this.title, required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: const Color(0xffF3F3F3),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: SvgPicture.asset(
              asset,
              color: const Color(0xff71B1FC),
              height: 20,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xff979797), fontSize: 12),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                desc,
              ),
            ],
          ),
        )
      ],
    );
  }
}
