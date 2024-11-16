import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/new_job_prference_controller.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class EnterJobPreference extends StatefulWidget {
  @override
  State<EnterJobPreference> createState() => _EnterJobPreferenceState();
}

class _EnterJobPreferenceState extends State<EnterJobPreference> {
  late NewJobPreferenceController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(NewJobPreferenceController());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 1.0,
        minChildSize: 0.7,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).jobPreference,
                          style: const TextStyle(
                            fontFamily: Environment.fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Choose at least 2 category \naccording your preference',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Environment.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 14),
                      controller.obx(
                        (state) {
                          return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 17,
                                mainAxisSpacing: 17,
                              ),
                              itemBuilder: (ctx, i) => JobBox(
                                  network: state[i].avatar!,
                                  title: state[i].name!,
                                  isSelected: controller.selectedJobs
                                      .contains(state[i]),
                                  onSelected: () {
                                    setState(() {
                                      if (controller.selectedJobs
                                          .contains(state[i])) {
                                        controller.selectedJobs
                                            .remove(state[i]);
                                      } else {
                                        if (controller.selectedJobs.length ==
                                            2) {
                                          SnackBarHelper.show(
                                              "You can choose max 2 jobs");
                                        } else {
                                          controller.selectedJobs
                                              .add(controller.jobs[i]);
                                        }
                                      }
                                    });
                                  }));
                        },
                        onLoading: Padding(
                          padding: EdgeInsets.only(top: Get.height / 3),
                          child: const Center(child: AppProgress()),
                        ),
                        onError: (e) => Padding(
                          padding: EdgeInsets.only(top: Get.height / 3),
                          child: AppErrorWidget(
                              title: e ?? S.of(context).someErrorOccurred,
                              onRetry: () {
                                controller.getAllJob();
                              }),
                        ),
                        onEmpty: Padding(
                          padding: EdgeInsets.only(top: Get.height / 3),
                          child: AppEmptyWidget(
                            title: S.of(context).noJobsFound,
                            onReload: () {
                              controller.getAllJob();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                controller.selectedJobs.length != 2
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AppPrimaryButton(
                          child: Text(S.of(context).next),
                          width: double.infinity,
                          onPressed: controller.completeStep4,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class JobBox extends StatelessWidget {
  final String title, network;
  final bool isSelected;
  final VoidCallback onSelected;

  const JobBox(
      {required this.title,
      required this.network,
      this.isSelected = false,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onSelected();
      },
      child: Container(
        height: 60,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 1, color: Color(isSelected ? 0xff268AFF : 0xffEAEAEA)),
          color: Color(isSelected ? 0xffDDEBFF : 0xffFFFFFF),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  network,
                  height: 40,
                  // color: Get.theme.primaryColor,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected ? Get.theme.primaryColor : Colors.black,
                      // fontWeight: FontWeight.w400,
                      // fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
            isSelected
                ? const Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.done,
                        size: 14,
                      ),
                    ))
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
