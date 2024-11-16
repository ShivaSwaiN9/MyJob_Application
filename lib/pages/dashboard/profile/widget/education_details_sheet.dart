import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class EducationDetailsSheet extends StatefulWidget {
  const EducationDetailsSheet({this.data, Key? key}) : super(key: key);
  final Education? data;
  @override
  _EducationDetailsSheetState createState() => _EducationDetailsSheetState();
}

class _EducationDetailsSheetState extends State<EducationDetailsSheet> {
  late RegisterDetailsController _controller;
  @override
  void initState() {
    super.initState();
    _controller = RegisterDetailsController();
    _controller.onInit();
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
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                widget.data == null
                                    ? "Add Educational Details"
                                    : 'Edit Educational Details',
                                style: const TextStyle(
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
                              const Text(
                                "Highest Education",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                  initialValue: widget.data?.highestEducation,
                                  validator: (v) =>
                                      AppFormValidators.validateEmpty(
                                          v, context),
                                  onSaved: _controller.onHighestEducationSaved,
                                  keyboardType: TextInputType.name,
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                          context)),
                              const SizedBox(height: 18),
                              const Text(
                                "Course",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                  initialValue: widget.data?.course,
                                  validator: (v) =>
                                      AppFormValidators.validateEmpty(
                                          v, context),
                                  onSaved: _controller.onCourseSaved,
                                  keyboardType: TextInputType.name,
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                          context)),
                              const SizedBox(height: 18),
                              const Text(
                                "University",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                  initialValue: widget.data?.university,
                                  validator: (v) =>
                                      AppFormValidators.validateEmpty(
                                          v, context),
                                  onSaved: _controller.onUniversitySaved,
                                  keyboardType: TextInputType.name,
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                          context)),
                              const SizedBox(height: 18),
                              const Text(
                                "Year Of Passing",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                  initialValue:
                                      widget.data?.yearOfPassing?.toString(),
                                  validator: _controller.yearOfPassingValidator,
                                  onSaved: _controller.onYearOfPassingSaved,
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration:
                                      AppDecorations.textFieldDecoration(
                                          context)),
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
        final educationList = SharedPreferenceHelper.user?.user?.education;
        final Map<String, dynamic> body = {};
        if (widget.data == null) {
          body["education"] = [
            {
              "highestEducation": _controller.highestEducation,
              "course": _controller.course,
              "university": _controller.university,
              "yearOfPassing": _controller.yearOfPassing
            },
            ...List<dynamic>.from(educationList!.map((e) => e.toJson())),
          ];
        } else {
          final index = educationList?.indexWhere((element) =>
              element.highestEducation == widget.data!.highestEducation);
          widget.data?.highestEducation = _controller.highestEducation;
          widget.data?.course = _controller.course;
          widget.data?.university = _controller.university;
          widget.data?.yearOfPassing = _controller.yearOfPassing.toString();
          educationList![index!] = widget.data!;
          body["education"] =
              List<dynamic>.from(educationList.map((e) => e.toJson()));
        }

        await AuthHelper.updateUser(body);
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
