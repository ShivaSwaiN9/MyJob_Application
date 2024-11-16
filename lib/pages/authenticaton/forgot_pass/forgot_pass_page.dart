import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass/forgot_pass_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const String routeName = '/forgotPassPage';
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  late ForgotPassController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ForgotPassController();
    _controller.onInit();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Form(
            key: _controller.formKey,
            autovalidateMode: _controller.autoValidateMode.value,
            child: Stack(children: [
              Image.asset(
                AppAssets.loginBackground,
                fit: BoxFit.cover,
                width: width,
              ),
              ListView(
                children: [
                  Row(
                    children: const [BackButton()],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    AppAssets.logo,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 69),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).registerToContinue,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Text(
                          S.of(context).provideWithYourEmailVerifyOtpToRegister,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff3C5F7B)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 3 + 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: S.of(context).loginWithEmail,
                            prefixIcon: SvgPicture.asset(
                              AppAssets.messageVector,
                              width: 24,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                          validator: (v) =>
                              AppFormValidators.validateMail(v, context),
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (v) => _controller.onEmailSaved(v),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppPrimaryButton(
                          key: _controller.buttonKey,
                          width: Get.width,
                          onPressed: _controller.forgotEmail,
                          child: Text(
                            S.of(context).sendOtp,
                            style: const TextStyle(
                              letterSpacing: 0,
                              fontSize: 16,
                            ),
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
            ]),
          ),
        ));
  }
}
