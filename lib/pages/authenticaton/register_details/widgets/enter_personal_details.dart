import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class EnterPersonalDetails extends StatefulWidget {
  final RegisterDetailsController controller;
  const EnterPersonalDetails(this.controller);

  @override
  State<EnterPersonalDetails> createState() => _EnterPersonalDetailsState();
}

class _EnterPersonalDetailsState extends State<EnterPersonalDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => Form(
        key: widget.controller.formKey1,
        autovalidateMode: widget.controller.autoValidateMode1.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(children: [
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).tellUsYourDetails,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: S.of(context).enterEmailId,
                prefixIcon: SvgPicture.asset(
                  AppAssets.messageVector,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: widget.controller.email,
              onSaved: (v) => widget.controller.onEmailSaved(v),
              validator: (v) => AppFormValidators.validateMail(v, context),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: S.of(context).enterPassword,
                suffixIcon: IconButton(
                    padding: const EdgeInsets.only(bottom: 0),
                    onPressed: () {
                      setState(() {
                        widget.controller.isActive =
                            !widget.controller.isActive;
                      });
                    },
                    icon: widget.controller.isActive
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off)),
                prefixIcon: SvgPicture.asset(
                  AppAssets.lockVector,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: widget.controller.password,
              obscureText: widget.controller.isActive ? true : false,
              onSaved: (v) => widget.controller.onPasswordSaved(v),
              onChanged: (v) {},
              keyboardType: TextInputType.visiblePassword,
              validator: (v) => AppFormValidators.validateEmpty(v, context),
              textCapitalization: TextCapitalization.none,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: S.of(context).enterYourName,
                prefixIcon: SvgPicture.asset(
                  AppAssets.profileVector,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: widget.controller.name,
              onSaved: (v) => widget.controller.onNameSaved(v),
              validator: (v) => AppFormValidators.validateEmpty(v, context),
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: S.of(context).phoneNo,
                prefixIcon: SvgPicture.asset(
                  AppAssets.phoneVector,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: widget.controller.phone,
              onSaved: (v) => widget.controller.onPhoneSaved(v),
              validator: (v) => AppFormValidators.validatePhone(v, context),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            FormField<int>(
              initialValue: widget.controller.gender,
              validator: widget.controller.genderValidator,
              onSaved: widget.controller.onGenderSaved,
              builder: (FormFieldState<int> state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GenderBox(
                        gender: 1,
                        isSelected: state.value == 1,
                        onSelected: () => state.didChange(1),
                      )),
                      const SizedBox(width: 18),
                      Expanded(
                          child: GenderBox(
                              gender: 2,
                              isSelected: state.value == 2,
                              onSelected: () => state.didChange(2))),
                      const SizedBox(width: 18),
                      Expanded(
                          child: GenderBox(
                              gender: 3,
                              isSelected: state.value == 3,
                              onSelected: () => state.didChange(3))),
                    ],
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6),
                      child: Text(
                        "${state.errorText}",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FormField<DateTime>(
                initialValue: widget.controller.dob,
                validator: widget.controller.dobValidator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: widget.controller.onDobSaved,
                builder: (FormFieldState<DateTime> state) => Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: AppColors.borderColor,
                                width: 1.2,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                final now = DateTime.now();
                                final picked = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1800, 1, 1, 1, 1),
                                    lastDate: now,
                                    initialDate: now);
                                if (picked != null) {
                                  state.didChange(picked);
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 18, 20, 18),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.calenderVector,
                                      color: theme.primaryColor,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                        child: state.value == null
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
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffBEBEBE),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                      DateFormat("dd.MM.yyyy")
                                                          .format(state.value!),
                                                      style: theme
                                                          .textTheme.subtitle1),
                                                ],
                                              ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (state.hasError)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 6),
                              child: Text("${state.errorText}",
                                  style: TextStyle(color: theme.errorColor)),
                            )
                        ])),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  // toggleable: false,
                  value: 1,
                  groupValue: widget.controller.maritalStatusSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.maritalStatusSelected = value as int?;
                    });
                  },
                ),
                Text(S.of(context).married),
                const SizedBox(
                  width: 10,
                ),
                Radio(
                  // autofocus: true,
                  // activeColor: color.primaryColor,
                  // focusColor: color.primaryColor,
                  // hoverColor: color.primaryColor,
                  // fillColor: MaterialStateProperty.all(color.primaryColor),
                  value: 2,
                  groupValue: widget.controller.maritalStatusSelected,
                  onChanged: (value) {
                    setState(() {
                      widget.controller.maritalStatusSelected = value as int?;
                    });
                  },
                ),
                Text(S.of(context).unmarried),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            AppPrimaryButton(
              child: Text(S.of(context).next),
              width: double.infinity,
              onPressed: widget.controller.completeStep1,
            ),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        )));
  }
}

class GenderBox extends StatelessWidget {
  final int gender;
  final bool isSelected;
  final VoidCallback onSelected;

  const GenderBox(
      {required this.gender,
      required this.isSelected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    String text;
    String selectedAsset;
    String unSelectedAsset;
    switch (gender) {
      case 1:
        text = S.of(context).male;
        selectedAsset = AppAssets.calenderVector;
        unSelectedAsset = AppAssets.lockVector;
        break;
      case 2:
        text = S.of(context).female;
        selectedAsset = AppAssets.calenderVector;
        unSelectedAsset = AppAssets.lockVector;
        break;
      default:
        text = S.of(context).others;
        selectedAsset = AppAssets.calenderVector;
        unSelectedAsset = AppAssets.lockVector;
    }
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   isSelected ? selectedAsset : unSelectedAsset,
            //   color: Get.theme.primaryColor,
            // ),
            // const SizedBox(
            //   width: 10,
            // ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Get.theme.primaryColor : Colors.black,
                // fontWeight: FontWeight.w400,
                // fontSize: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
