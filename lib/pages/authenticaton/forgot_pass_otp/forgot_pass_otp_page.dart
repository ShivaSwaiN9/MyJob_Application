import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_otp/forgot_pass_otp_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ForgotPassOtpPage extends StatefulWidget {
  static const String routeName = '/ForgotOtp';

  const ForgotPassOtpPage({Key? key}) : super(key: key);

  @override
  _ForgotPassOtpPageState createState() => _ForgotPassOtpPageState();
}

class _ForgotPassOtpPageState extends State<ForgotPassOtpPage>
    with CodeAutoFill {
  late ForgotOtpController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = ForgotOtpController();
    _otpController.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    unregisterListener();
    cancel();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Image.asset(
            AppAssets.loginBackground,
            fit: BoxFit.cover,
            width: width,
          ),
          ListView(
            children: [
              Row(
                children: const [
                  AppBackButton(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                AppAssets.logo,
                height: 60,
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      S.of(context).verifyOtp,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      "${S.of(context).pleaseEnterTheOtpThatHasBeenSentToYour}"
                      " ${S.of(context).emailId}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff3C5F7B)),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 60,),
              Container(
                  width: 250,
                  margin: const EdgeInsets.only(
                      left: 16, right: 16, top: 60, bottom: 50),
                  child: PinCodeTextField(
                    controller: _otpController.textController,
                    appContext: context,
                    length: 6,
                    autoDisposeControllers: false,
                    onChanged: _otpController.onChanged,
                    onSubmitted: (v) => _otpController.onCompleted(v, context),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                    onCompleted: (s) {
                      _otpController.resetUsingOtp(context);
                    },
                    pinTheme: PinTheme(
                      fieldHeight: 63,
                      fieldWidth: 46,
                      shape: PinCodeFieldShape.box,
                      borderWidth: 2,
                      borderRadius: BorderRadius.circular(15),
                      activeColor: theme.primaryColor,
                      inactiveColor: AppColors.borderColor,
                      selectedColor: theme.primaryColor,
                    ),
                  )),
              // const SizedBox(height: 40,),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _otpController.timerText,
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
                                  color: _otpController.isResendActive.value
                                      ? theme.primaryColor
                                      : Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (_otpController.isResendActive.value) {
                                _otpController.regenerateOTP();
                              }
                            })
                    ])),
                  ],
                ),
              ),
              SizedBox(height: height / 5.5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppPrimaryButton(
                  key: _otpController.buttonKey,
                  width: Get.width,
                  onPressed: () => _otpController.resetUsingOtp(context),
                  child: Text(S.of(context).verify),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ]));
  }

  @override
  void codeUpdated() {
    return _otpController.onCodeUpdated(code!);
  }
}
