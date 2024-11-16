import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sisira Sahoo
/// On 08/07/22 2:11 PM
///
class ProjectDetailsSheet extends StatefulWidget {
  final Project? datum;
  const ProjectDetailsSheet({this.datum, Key? key}) : super(key: key);

  @override
  State<ProjectDetailsSheet> createState() => _ProjectDetailsSheetState();
}

class _ProjectDetailsSheetState extends State<ProjectDetailsSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, description, link;
  DateTime? startDate, endDate;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  onNameSaved(String? value) {
    name = value?.trim();
  }

  onDescriptionSaved(String? value) {
    description = value?.trim();
  }

  onLinkSaved(String? value) {
    link = value?.trim();
  }

  onStartDateSaved(DateTime? value) {
    startDate = value;
  }

  onEndDateSaved(DateTime? value) {
    endDate = value;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff7D7D7D));
    return Form(
      key: formKey,
      autovalidateMode: autoValidateMode,
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
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            widget.datum == null
                                ? 'Add Project Details'
                                : 'Edit Project Details',
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
                          Text("Name", style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.datum?.name,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onNameSaved,
                            decoration:
                                AppDecorations.textFieldDecoration(context)
                                    .copyWith(
                                        prefixIconConstraints:
                                            const BoxConstraints.tightFor(
                                                width: 54)),
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 18),
                          Text("Description", style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.datum?.description,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onDescriptionSaved,
                            decoration:
                                AppDecorations.textFieldDecoration(context)
                                    .copyWith(
                                        prefixIconConstraints:
                                            const BoxConstraints.tightFor(
                                                width: 54)),
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 18),
                          Text("Link", style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.datum?.link,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onLinkSaved,
                            decoration:
                                AppDecorations.textFieldDecoration(context)
                                    .copyWith(
                                        prefixIconConstraints:
                                            const BoxConstraints.tightFor(
                                                width: 54)),
                            keyboardType: TextInputType.url,
                            // textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Expanded(
                                child: FormField<DateTime>(
                                    initialValue: widget.datum?.startDate,
                                    validator: (data) =>
                                        AppFormValidators.validateEmpty(
                                            data, context),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onSaved: onStartDateSaved,
                                    builder: (FormFieldState<DateTime> state) =>
                                        Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Material(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  side: BorderSide(
                                                    color: state.hasError
                                                        ? Get.theme.errorColor
                                                        : AppColors.borderColor,
                                                    width: 1.2,
                                                  ),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.antiAlias,
                                                child: InkWell(
                                                  onTap: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    final now = DateTime.now();
                                                    final picked =
                                                        await showDatePicker(
                                                            context: context,
                                                            firstDate: DateTime(
                                                                1800,
                                                                1,
                                                                1,
                                                                1,
                                                                1),
                                                            lastDate: now,
                                                            initialDate: now);
                                                    if (picked != null) {
                                                      state.didChange(picked);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        16, 12, 16, 12),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppAssets
                                                              .calenderVector,
                                                          color: Get.theme
                                                              .primaryColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Expanded(
                                                            child:
                                                                state.value ==
                                                                        null
                                                                    ? Text(
                                                                        S
                                                                            .of(context)
                                                                            .start,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xffBEBEBE),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      )
                                                                    : Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            S.of(context).start,
                                                                            style: const TextStyle(
                                                                                color: Color(0xffBEBEBE),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 10),
                                                                          ),
                                                                          Text(
                                                                              DateFormat("dd.MM.yyyy").format(state.value!),
                                                                              style: Get.theme.textTheme.subtitle1),
                                                                        ],
                                                                      ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (state.hasError)
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18,
                                                      vertical: 6),
                                                  child: Text(
                                                      "${state.errorText}",
                                                      style: TextStyle(
                                                          color: Get.theme
                                                              .errorColor)),
                                                )
                                            ])),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: FormField<DateTime>(
                                    initialValue: widget.datum?.endDate,
                                    validator: (data) =>
                                        AppFormValidators.validateEmpty(
                                            data, context),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    onSaved: onEndDateSaved,
                                    builder: (FormFieldState<DateTime> state) =>
                                        Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Material(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  side: BorderSide(
                                                    color: state.hasError
                                                        ? Get.theme.errorColor
                                                        : AppColors.borderColor,
                                                    width: 1.2,
                                                  ),
                                                ),
                                                color: Colors.white,
                                                clipBehavior: Clip.antiAlias,
                                                child: InkWell(
                                                  onTap: () async {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    final now = DateTime.now();
                                                    final picked =
                                                        await showDatePicker(
                                                            context: context,
                                                            firstDate: DateTime(
                                                                1800,
                                                                1,
                                                                1,
                                                                1,
                                                                1),
                                                            lastDate: now,
                                                            initialDate: now);
                                                    if (picked != null) {
                                                      state.didChange(picked);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        16, 12, 16, 12),
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppAssets
                                                              .calenderVector,
                                                          color: Get.theme
                                                              .primaryColor,
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Expanded(
                                                            child:
                                                                state.value ==
                                                                        null
                                                                    ? Text(
                                                                        S
                                                                            .of(context)
                                                                            .end,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xffBEBEBE),
                                                                            fontWeight: FontWeight.w400,
                                                                            fontSize: 14),
                                                                      )
                                                                    : Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            S.of(context).end,
                                                                            style: const TextStyle(
                                                                                color: Color(0xffBEBEBE),
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 10),
                                                                          ),
                                                                          Text(
                                                                              DateFormat("dd.MM.yyyy").format(state.value!),
                                                                              style: Get.theme.textTheme.subtitle1),
                                                                        ],
                                                                      ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if (state.hasError)
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18,
                                                      vertical: 6),
                                                  child: Text(
                                                      "${state.errorText}",
                                                      style: TextStyle(
                                                          color: Get.theme
                                                              .errorColor)),
                                                )
                                            ])),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: AppPrimaryButton(
                            child: Text(S.of(context).save),
                            key: buttonKey,
                            onPressed: saveUser,
                            width: double.infinity),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Future<void> saveUser() async {
    final state = formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      autoValidateMode = AutovalidateMode.always;
      setState(() {});
    } else {
      state.save();
      try {
        buttonKey.currentState?.showLoader();
        final empList = SharedPreferenceHelper.user?.user?.project;
        final Map<String, dynamic> body = {};
        if (widget.datum == null) {
          body["project"] = [
            {
              "name": name,
              "description": description,
              "link": link,
              "startDate": startDate?.toIso8601String(),
              "endDate": endDate?.toIso8601String(),
            },
            ...List<dynamic>.from(empList!.map((e) => e.toJson())),
          ];
        } else {
          final index =
              empList?.indexWhere((element) => element.id == widget.datum!.id);

          widget.datum?.name = name;
          widget.datum?.description = description;
          widget.datum?.startDate = startDate;
          widget.datum?.endDate = endDate;
          widget.datum?.link = link;
          empList![index!] = widget.datum!;
          body["project"] = List<dynamic>.from(empList.map((e) => e.toJson()));
        }

        await AuthHelper.updateUser(body);
        SnackBarHelper.show("Profile updated successfully.");
        Get.back();
      } catch (e, s) {
        log('Error $e', stackTrace: s);
        SnackBarHelper.show(e.toString());
      } finally {
        buttonKey.currentState?.hideLoader();
      }
    }
  }
}
