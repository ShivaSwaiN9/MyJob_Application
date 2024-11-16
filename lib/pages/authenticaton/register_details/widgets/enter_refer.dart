import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class EnterRefer extends StatelessWidget {
  final RegisterDetailsController controller;
  const EnterRefer(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
        key: controller.formKey4,
        autovalidateMode: controller.autoValidateMode4.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              SvgPicture.asset(AppAssets.referralVector),
              const SizedBox(
                height: 20,
              ),
              Text(
                S.of(context).referral,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Get.theme.primaryColor,
                    fontSize: 17),
              ),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                decoration:
                    AppDecorations.textFieldDecoration(context).copyWith(
                  labelText: S.of(context).enterReferCode,
                  // prefixIcon: SvgPicture.asset(
                  //   AppAssets.profileVector,
                  //   width: 24,
                  //   color: Get.theme.primaryColor,
                  // ),
                ),
                initialValue: controller.referralCode,
                onSaved: (v) => controller.onReferSaved(v),
                validator: (v) => AppFormValidators.validateEmpty(v, context),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.singleLineFormatter
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4 - 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: AppOutlineButton(
                    onPressed: controller.skipStep3,
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
                    onPressed: controller.completeStep4,
                    child: Text(S.of(context).next),
                  )),
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
        )));
  }
}
