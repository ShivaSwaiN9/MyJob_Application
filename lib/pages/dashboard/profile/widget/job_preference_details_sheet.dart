import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/job_dm.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/widgets/enter_personal_details.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';

class JobPreferenceDetailsSheet extends StatefulWidget {
  const JobPreferenceDetailsSheet(this.data, {Key? key}) : super(key: key);
  final UserData data;
  @override
  _JobPreferenceDetailsSheetState createState() =>
      _JobPreferenceDetailsSheetState();
}

class _JobPreferenceDetailsSheetState extends State<JobPreferenceDetailsSheet> {
  late RegisterDetailsController _controller;
  @override
  void initState() {
    super.initState();
    _controller = RegisterDetailsController();
    _controller.onInit();
    _controller.getAllJob().then((value) {
      _controller.onJobSaved1(_controller.jobs.firstWhere(
          (element) => widget.data.primaryJobPreference == element.name));
      _controller.onJobSaved2(_controller.jobs.firstWhere(
          (element) => widget.data.secondaryJobPreference == element.name));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff7D7D7D));
    return Obx(() => Form(
          key: _controller.formKey1,
          autovalidateMode: _controller.autoValidateMode1.value,
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Material(
                      child: SizedBox(
                        height: 8,
                        width: 80,
                      ),
                      color: Color(0xffFFFFFF),
                      shape: StadiumBorder(),
                    ),
                  ),
                  Material(
                    color: const Color(0xffFFFFFF),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Edit Job Preference details',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).job1,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              GetBuilder<RegisterDetailsController>(
                                  init: _controller,
                                  id: 0,
                                  builder: (controller) {
                                    return DropdownSearch<JobDatum>(
                                      autoValidateMode:
                                          controller.autoValidateMode3.value,
                                      // mode: Mode.MENU,
                                      compareFn: (a, b) => a == b,
                                      // showSearchBox: true,
                                      // showSelectedItems: true,
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                        emptyBuilder: (ctx, i) {
                                          return AppEmptyWidget(
                                            title: S.of(context).noJobFound,
                                            onReload: controller.getAllJob,
                                          );
                                        },
                                      ),
                                      items: controller.jobs,
                                      validator: (v) =>
                                          AppFormValidators.validateEmpty(
                                              v, context),
                                      itemAsString: (JobDatum? u) => u!.name!,
                                      // label: S.of(context).enterYourJob,
                                      onChanged: controller.onJobSaved1,
                                      onSaved: controller.onJobSaved1,
                                      selectedItem: controller.selectedJob1,
                                    );
                                  }),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  S.of(context).job2,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Environment.fontFamily,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GetBuilder<RegisterDetailsController>(
                                init: _controller,
                                id: 1,
                                builder: (controller) =>
                                    DropdownSearch<JobDatum>(
                                  autoValidateMode:
                                      controller.autoValidateMode3.value,
                                  popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    emptyBuilder: (ctx, i) {
                                      return AppEmptyWidget(
                                        title: S.of(context).noJobFound,
                                        onReload: controller.getAllJob,
                                      );
                                    },
                                  ),
                                  compareFn: (a, b) => a == b,
                                  items: controller.jobs,
                                  itemAsString: (JobDatum? u) => u!.name!,
                                  onChanged: controller.onJobSaved2,
                                  onSaved: controller.onJobSaved2,
                                  selectedItem: controller.selectedJob2,
                                  validator: (v) =>
                                      AppFormValidators.validateEmpty(
                                          v, context),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: AppPrimaryButton(
                                child: const Text('Save'),
                                key: _controller.buttonKey,
                                onPressed: saveUser,
                                width: double.infinity),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  Future<void> saveUser() async {
    final state = _controller.formKey1.currentState;
    if (state == null) return;
    if (!state.validate()) {
      _controller.autoValidateMode1.value = AutovalidateMode.always;
      setState(() {});
    } else {
      state.save();
      try {
        _controller.buttonKey.currentState?.showLoader();

        await AuthHelper.updateUser({
          "primaryJobPreference": _controller.selectedJob1?.name,
          "secondaryJobPreference": _controller.selectedJob2?.name,
        });
        _controller.buttonKey.currentState?.hideLoader();
        SnackBarHelper.show("Profile updated successfully.");
        Get.back();
      } catch (e, s) {
        log('Error $e', stackTrace: s);
        _controller.buttonKey.currentState?.hideLoader();
        SnackBarHelper.show(e.toString());
      }
    }
  }
}
