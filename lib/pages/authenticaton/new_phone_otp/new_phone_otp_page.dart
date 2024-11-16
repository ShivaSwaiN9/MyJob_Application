import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone_otp/new_phone_otp_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

///
/// Created by Sisira Sahoo
/// On 16/04/22 6:18 PM
///

class NewPhoneOtpPage extends StatefulWidget {
  final String phone;
  const NewPhoneOtpPage({Key? key, required this.phone}) : super(key: key);

  @override
  State<NewPhoneOtpPage> createState() => _NewPhoneOtpPageState();
}

class _NewPhoneOtpPageState extends State<NewPhoneOtpPage> with CodeAutoFill {
  late LoginPhoneOtpController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginPhoneOtpController(widget.phone);
    controller.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    unregisterListener();
    cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBackButton(),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  S.of(context).enterOtp,
                  style: const TextStyle(
                    fontSize: 16,
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const Divider(),
                  RichText(
                    text: TextSpan(
                        text: S
                            .of(context)
                            .pleaseEnterTheOtpThatHasBeenSentToYour,
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: Environment.fontFamily,
                            color: Color(0xff424242)),
                        children: [
                          TextSpan(
                              text:
                                  "${controller.phone?.replaceRange(3, 6, "*" * 6)}",
                              style: TextStyle(
                                  fontFamily: Environment.fontFamily,
                                  color: Theme.of(context).primaryColor))
                        ]),
                  ),
                  Container(
                      width: Get.width,
                      margin: const EdgeInsets.only(
                          left: 0, right: 0, top: 40, bottom: 20),
                      child: PinCodeTextField(
                        // controller: _otpController.textController,
                        appContext: context,
                        length: 6,
                        autoDisposeControllers: false,
                        onChanged: controller.onChanged,
                        onSubmitted: controller.onCompleted,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        onCompleted: (s) {
                          controller.loginUsingOtp();
                        },
                        pinTheme: PinTheme(
                          fieldHeight: 65,
                          fieldWidth: 44,
                          shape: PinCodeFieldShape.box,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(15),
                          activeColor: Get.theme.primaryColor,
                          inactiveColor: AppColors.borderColor,
                          selectedColor: Get.theme.primaryColor,
                        ),
                      )),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.timerText,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: S.of(context).didntReceiveTheCode,
                              style: const TextStyle(color: Colors.grey)),
                          TextSpan(
                              text: S.of(context).resend,
                              style: const TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 12)
                                  .copyWith(
                                      color: controller.isResendActive.value
                                          ? Get.theme.primaryColor
                                          : Colors.grey),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (controller.isResendActive.value) {
                                    controller.regenerateOTP();
                                  }
                                })
                        ])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppPrimaryButton(
                      key: controller.buttonKey,
                      width: Get.width,
                      onPressed: controller.loginUsingOtp,
                      child: Text(S.of(context).verify),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void codeUpdated() {
    return controller.onCodeUpdated(code!);
  }
}
