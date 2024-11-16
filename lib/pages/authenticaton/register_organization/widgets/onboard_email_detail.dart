import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_org_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class OnboardEmail extends StatefulWidget {
  final RegisterOrgController controller;
  const OnboardEmail(this.controller);

  @override
  State<OnboardEmail> createState() => _OnboardEmailState();
}

class _OnboardEmailState extends State<OnboardEmail> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: widget.controller.formKey2,
        autovalidateMode: widget.controller.autoValidateMode2.value,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SvgPicture.asset(AppAssets.orgOnboardVector),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Login Details',
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
              'Tell us your login information which will\nbe used by you for logging in.',
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
              height: 16,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                  labelText: S.of(context).enterPassword,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.lockVector,
                    width: 24,
                    color: Get.theme.primaryColor,
                  ),
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
                          : const Icon(Icons.visibility_off))),
              obscureText: widget.controller.isActive ? true : false,
              onChanged: (v) => widget.controller.onPasswordSaved(v),
              initialValue: widget.controller.password,
              onSaved: (v) => widget.controller.onPasswordSaved(v),
              validator: (v) => AppFormValidators.validateEmpty(v, context),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                  labelText: S.of(context).confirmPassword,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.lockVector,
                    width: 24,
                    color: Get.theme.primaryColor,
                  ),
                  suffixIcon: IconButton(
                      padding: const EdgeInsets.only(bottom: 0),
                      onPressed: () {
                        setState(() {
                          widget.controller.isActive1 =
                              !widget.controller.isActive1;
                        });
                      },
                      icon: widget.controller.isActive1
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off))),
              obscureText: widget.controller.isActive1 ? true : false,
              onChanged: (v) => widget.controller.onConfirmPasswordSaved(v),
              initialValue: widget.controller.password,
              onSaved: (v) => widget.controller.onConfirmPasswordSaved(v),
              validator: (v) =>
                  widget.controller.confirmPasswordValidator(v, context),
              keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 38),
            AppPrimaryButton(
                key: widget.controller.buttonKey,
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
                child: const Text('Next'),
                onPressed: widget.controller.completeStep2)
          ],
        ),
      ),
    );
  }
}
