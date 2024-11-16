import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_org_controller.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_outline_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class UploadDp extends StatelessWidget {
  final RegisterOrgController controller;
  UploadDp(this.controller);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        SizedBox(
          height: height / 10,
        ),
        Text(
          'Organization logo',
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
          'Please upload your logo / picture to\nmake your organization look genuine',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Environment.fontFamily,
            color: Color(0xffACACAC),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: controller.chooseProfilePicture,
          // onTap: () {},
          child: GetBuilder<RegisterOrgController>(
            autoRemove: false,
            init: controller,
            builder: (controller) => Container(
                width: 120,
                height: 120,
                // padding: const EdgeInsets.all(46),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffEBF4FF),
                ),
                clipBehavior: Clip.antiAlias,
                child: controller.image != null
                    ? Image.file(controller.image!, fit: BoxFit.cover)
                    : SharedPreferenceHelper.user?.user?.avatar?.isNotEmpty ??
                            false
                        ? Image.network(
                            SharedPreferenceHelper.user!.user!.avatar!,
                            fit: BoxFit.cover)
                        : Padding(
                            padding: const EdgeInsets.all(46),
                            child: SvgPicture.asset(
                              AppAssets.galleryIcon,
                              color: Get.theme.primaryColor,
                            ),
                          )),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Click here to upload your profile picture',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Get.theme.primaryColor,
            fontSize: 12,
            fontFamily: Environment.fontFamily,
          ),
        ),
        SizedBox(
          height: Get.height / 4,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: AppOutlineButton(
                    onPressed: controller.skipStep3,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0,
                          fontFamily: Environment.fontFamily,
                          color: Colors.black),
                    )),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: AppPrimaryButton(
                    key: controller.buttonKey,
                    onPressed: controller.completeStep3,
                    child: const Text('Next')),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).viewInsets.bottom,
        ),
      ],
    );
  }
}
