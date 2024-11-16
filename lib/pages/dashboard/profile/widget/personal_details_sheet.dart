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
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/widgets/enter_personal_details.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class PersonalDetailsSheet extends StatefulWidget {
  const PersonalDetailsSheet(this.data, {Key? key}) : super(key: key);
  final UserData data;
  @override
  _PersonalDetailsSheetState createState() => _PersonalDetailsSheetState();
}

class _PersonalDetailsSheetState extends State<PersonalDetailsSheet> {
  late RegisterDetailsController _controller;
  @override
  void initState() {
    super.initState();
    _controller = RegisterDetailsController();
    _controller.onInit();
    _controller.maritalStatusSelected = widget.data.maritalStatus;
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
                        const SizedBox(height: 22),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Edit Personal details',
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
                                "Email",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                  labelText: 'Enter Email ID',
                                  // prefixIcon: SvgPicture.asset(
                                  //   AppAssets.messageVector,
                                  //   width: 19,
                                  //   color: Get.theme.primaryColor,
                                  // ),
                                ),
                                initialValue: widget.data.email,
                                onSaved: (v) => _controller.onEmailSaved(v),
                                validator: (v) =>
                                    AppFormValidators.validateMail(v, context),
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                S.of(context).gender,
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              FormField<int>(
                                initialValue: widget.data.gender,
                                validator: _controller.genderValidator,
                                onSaved: _controller.onGenderSaved,
                                builder: (FormFieldState<int> state) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: GenderBox(
                                                gender: 1,
                                                isSelected: state.value == 1,
                                                onSelected: () =>
                                                    state.didChange(1))),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Expanded(
                                            child: GenderBox(
                                                gender: 2,
                                                isSelected: state.value == 2,
                                                onSelected: () =>
                                                    state.didChange(2))),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        Expanded(
                                            child: GenderBox(
                                                gender: 3,
                                                isSelected: state.value == 3,
                                                onSelected: () =>
                                                    state.didChange(3)))
                                      ],
                                    ),
                                    if (state.hasError)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 6),
                                        child: Text(
                                          '${state.errorText}',
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).errorColor),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                S.of(context).phoneNo,
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                enabled: false,
                                initialValue: widget.data.phone,
                                validator: (v) =>
                                    AppFormValidators.validatePhone(v, context),
                                onSaved: _controller.onPhoneSaved,
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                            prefixIconConstraints:
                                                const BoxConstraints.tightFor(
                                                    width: 54)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                S.of(context).dateOfBirth,
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              FormField<DateTime>(
                                  initialValue: widget.data.dob,
                                  validator: _controller.dobValidator,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onSaved: _controller.onDobSaved,
                                  builder:
                                      (FormFieldState<DateTime> state) =>
                                          Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Material(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    side: BorderSide(
                                                      color: state.hasError
                                                          ? Get.theme.errorColor
                                                          : AppColors
                                                              .borderColor,
                                                      width: 1.2,
                                                    ),
                                                  ),
                                                  color: Colors.white,
                                                  clipBehavior: Clip.antiAlias,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                      final now =
                                                          DateTime.now();
                                                      final picked =
                                                          await showDatePicker(
                                                              context: context,
                                                              firstDate:
                                                                  DateTime(
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
                                                          20, 18, 20, 18),
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
                                                                          S.of(context).dateOfBirth,
                                                                          style: const TextStyle(
                                                                              color: Color(0xffBEBEBE),
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14),
                                                                        )
                                                                      : Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              S.of(context).dateOfBirth,
                                                                              style: const TextStyle(color: Color(0xffBEBEBE), fontWeight: FontWeight.w400, fontSize: 10),
                                                                            ),
                                                                            Text(DateFormat("dd.MM.yyyy").format(state.value!),
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
                              const SizedBox(height: 18),
                              Text(
                                "Bio",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                initialValue: widget.data.bio,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: _controller.onBioSaved,
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                            prefixIconConstraints:
                                                const BoxConstraints.tightFor(
                                                    width: 54)),
                                keyboardType: TextInputType.multiline,
                                minLines: 2,
                                maxLines: 3,
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue:
                                        _controller.maritalStatusSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.maritalStatusSelected =
                                            value as int?;
                                      });
                                    },
                                  ),
                                  Text(S.of(context).married),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue:
                                        _controller.maritalStatusSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        _controller.maritalStatusSelected =
                                            value as int?;
                                      });
                                    },
                                  ),
                                  Text(S.of(context).unmarried),
                                ],
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Address",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                initialValue:
                                    widget.data.address?.permanentAddress,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: _controller.onAddressSaved,
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                            prefixIconConstraints:
                                                const BoxConstraints.tightFor(
                                                    width: 54)),
                                keyboardType: TextInputType.multiline,
                                minLines: 2,
                                maxLines: 3,
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                "Pincode",
                                style: titleStyle,
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                initialValue: widget.data.address?.pin,
                                validator: (v) =>
                                    AppFormValidators.validateEmpty(v, context),
                                onSaved: _controller.onPinCodeSaved,
                                decoration:
                                    AppDecorations.textFieldDecoration(context)
                                        .copyWith(
                                            prefixIconConstraints:
                                                const BoxConstraints.tightFor(
                                                    width: 54)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputAction: TextInputAction.done,
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
          'email': _controller.email,
          'gender': _controller.gender,
          "phone": _controller.phone,
          "dob": _controller.dob?.toIso8601String(),
          "maritalStatus": _controller.maritalStatusSelected,
          "bio": _controller.bio,
          "address": {
            "permanentAddress": _controller.address,
            "pin": _controller.pinCode
          },
        });
        _controller.buttonKey.currentState?.hideLoader();
        SnackBarHelper.show("Profile updated successfully.");
        Get.back();
      } catch (e, s) {
        log('Error $e', stackTrace: s);
        _controller.buttonKey.currentState?.hideLoader();
        SnackBarHelper.show(_controller.email);
      }
    }
  }
}
