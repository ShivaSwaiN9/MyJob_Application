import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class EnterEducation extends StatelessWidget {
  final RegisterDetailsController controller;
  const EnterEducation(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
          key: controller.formKey2,
          autovalidateMode: controller.autoValidateMode2.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).tellUsYourEducation,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    labelText: S.of(context).enterYourHighestEducation,
                  ),
                  // svgAsset: AppAssets.profileVector,
                  initialValue: controller.highestEducation,
                  onSaved: (v) => controller.onHighestEducationSaved(v),
                  validator: (v) => AppFormValidators.validateEmpty(v, context),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    labelText: S.of(context).courseName,
                  ),
                  // svgAsset: AppAssets.profileVector,
                  initialValue: controller.course,
                  onSaved: (v) => controller.onCourseSaved(v),
                  validator: (v) => AppFormValidators.validateEmpty(v, context),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    labelText: S.of(context).universityName,
                  ),
                  // svgAsset: AppAssets.profileVector,
                  initialValue: controller.university,
                  onSaved: (v) => controller.onUniversitySaved(v),
                  validator: (v) => AppFormValidators.validateEmpty(v, context),
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration:
                      AppDecorations.textFieldDecoration(context).copyWith(
                    labelText: S.of(context).yearOfPassing,
                  ),
                  // svgAsset: AppAssets.profileVector,
                  initialValue: controller.yearOfPassing?.toString() ?? '',
                  validator: (v) =>
                      controller.yearOfPassingValidator(v, context: context),
                  onSaved: (v) => controller.onYearOfPassingSaved(v),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Row(
                  children: [
                    Expanded(
                        child: AppOutlineButton(
                      onPressed: controller.skipStep2,
                      child: Text(
                        S.of(context).skip,
                        style: const TextStyle(
                            fontSize: 14,
                            letterSpacing: 0,
                            fontFamily: Environment.fontFamily,
                            color: Colors.black),
                      ),
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AppPrimaryButton(
                        child: Text(S.of(context).next),
                        width: double.infinity,
                        onPressed: controller.completeStep2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
