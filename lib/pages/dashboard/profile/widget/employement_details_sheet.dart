import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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

class EmploymentDetailsSheet extends StatefulWidget {
  const EmploymentDetailsSheet({this.data, Key? key}) : super(key: key);
  final Employment? data;
  @override
  _EmploymentDetailsSheetState createState() => _EmploymentDetailsSheetState();
}

class _EmploymentDetailsSheetState extends State<EmploymentDetailsSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? organisation, designation, responsibility;
  DateTime? startDate, endDate;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();

  onOrganisationSaved(String? value) {
    organisation = value?.trim();
  }

  onDesignationSaved(String? value) {
    designation = value?.trim();
  }

  onResponsibilitySaved(String? value) {
    responsibility = value?.trim();
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
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            widget.data == null
                                ? "Add Employment Details"
                                : 'Edit Employment Details',
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
                          Text(S.of(context).organisation, style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.data?.organisation,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onOrganisationSaved,
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
                          Text(S.of(context).designation, style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.data?.designation,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onDesignationSaved,
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
                          Row(
                            children: [
                              Expanded(
                                child: FormField<DateTime>(
                                    initialValue: widget.data?.startFrom,
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
                                    initialValue: widget.data?.endFrom,
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

                                                    state.didChange(picked);
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
                                                            child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              S.of(context).end,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xffBEBEBE),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10),
                                                            ),
                                                            Text(
                                                                state.value ==
                                                                        null
                                                                    ? ""
                                                                    : DateFormat(
                                                                            "dd.MM.yyyy")
                                                                        .format(state
                                                                            .value!),
                                                                style: Get
                                                                    .theme
                                                                    .textTheme
                                                                    .subtitle1),
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
                          Text(S.of(context).responsibility, style: titleStyle),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: widget.data?.responsibility,
                            validator: (v) =>
                                AppFormValidators.validateEmpty(v, context),
                            onSaved: onResponsibilitySaved,
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
        final empList = SharedPreferenceHelper.user?.user?.employment;
        final Map<String, dynamic> body = {};
        if (widget.data == null) {
          body["employment"] = [
            {
              "organisation": organisation,
              "designation": designation,
              "startFrom": startDate?.toIso8601String(),
              "endFrom": endDate?.toIso8601String(),
              "responsibility": responsibility,
            },
            ...List<dynamic>.from(empList!.map((e) => e.toJson())),
          ];
        } else {
          final index = empList?.indexWhere(
              (element) => element.organisation == widget.data!.organisation);

          widget.data?.organisation = organisation;
          widget.data?.designation = designation;
          widget.data?.startFrom = startDate;
          widget.data?.endFrom = endDate;
          widget.data?.responsibility = responsibility;
          empList![index!] = widget.data!;
          body["employment"] =
              List<dynamic>.from(empList.map((e) => e.toJson()));
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
