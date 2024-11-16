import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_org_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
///Created By Sisira Sahoo (coolsisira1998@gmail.com) on 22-02-2022 07:42
///

class OnboardName extends StatelessWidget {
  final RegisterOrgController controller;
  const OnboardName(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formKey1,
        autovalidateMode: controller.autoValidateMode1.value,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SvgPicture.asset(AppAssets.orgOnboardVector),
            const SizedBox(height: 30),
            Text(
              'Organization Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 14,
            ),
            const Text(
              'Tell us some information about your\norganizations to continue',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffACACAC),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: 'Enter Organization name',
                prefixIcon: SvgPicture.asset(
                  AppAssets.orgFieldIcon,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: controller.orgName,
              onSaved: (v) => controller.onOrgNameSaved(v),
              validator: (v) => AppFormValidators.validateEmpty(v, context),
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
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
              initialValue: controller.name,
              onSaved: (v) => controller.onNameSaved(v),
              validator: (v) => AppFormValidators.validateEmpty(v, context),
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                labelText: S.of(context).enterEmailId,
                prefixIcon: SvgPicture.asset(
                  AppAssets.messageVector,
                  width: 24,
                  color: Get.theme.primaryColor,
                ),
              ),
              initialValue: controller.email,
              onSaved: (v) => controller.onEmailSaved(v),
              validator: (v) => AppFormValidators.validateMail(v, context),
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 38),
            AppPrimaryButton(
                child: const Text('Next'), onPressed: controller.completeStep1),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
