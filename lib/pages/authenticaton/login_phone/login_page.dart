           import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_colors.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass/forgot_pass_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_options/register_options_page.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

///
/// Created by Sunil Kumar from Boiler plate
///

class LoginPage extends StatefulWidget {
  static const String routeName = '/LoginPage';

  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late LoginPhoneController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = LoginPhoneController();
    _emailController.onInit();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Form(
            key: _emailController.formKey,
            autovalidateMode: _emailController.autoValidateMode.value,
            child: Stack(children: [
              Image.asset(
                AppAssets.loginBackground,
                fit: BoxFit.cover,
                width: width,
              ),
              ListView(
                children: [
                  const SizedBox(
                    height: 50,
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
                          S.of(context).loginToContinue,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Text(
                          S
                              .of(context)
                              .loginWithYourRegisteredEmailIdPasswordToContinue,
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
                    height: height / 4 - 20,
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
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (v) => _emailController.onEmailSaved(v),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: AppDecorations.textFieldDecoration(
                                      context)
                                  .copyWith(
                                      labelText: S.of(context).yourPassword,
                                      prefixIcon: SvgPicture.asset(
                                        AppAssets.lockVector,
                                        width: 24,
                                        color: Get.theme.primaryColor,
                                      ),
                                      suffixIcon: IconButton(
                                          padding:
                                              const EdgeInsets.only(bottom: 0),
                                          onPressed: () {
                                            setState(() {
                                              _emailController.isActive =
                                                  !_emailController.isActive;
                                            });
                                          },
                                          icon: _emailController.isActive
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off))),
                              obscureText:
                                  _emailController.isActive ? true : false,
                              validator: (v) =>
                                  AppFormValidators.validateEmpty(v, context),
                              textCapitalization: TextCapitalization.none,
                              onSaved: (v) => _emailController.onPassSaved(v),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(ForgotPasswordPage.routeName);
                            },
                            child: Text(
                              S.of(context).forgotPassword,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: AppColors.brightPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppPrimaryButton(
                          key: _emailController.buttonKey,
                          width: Get.width,
                          onPressed: _emailController.login,
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(
                              letterSpacing: 0,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RichText(
                            text: TextSpan(
                                text: S.of(context).dontHaveAnAccount,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: Environment.fontFamily,
                                    color: Color(0xff818181)),
                                children: [
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.focusScope?.unfocus();
                                          Get.toNamed(
                                              RegisterOptionsPage.routeName);
                                        },
                                      text: " ${S.of(context).register}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: Environment.fontFamily,
                                          color:
                                              Theme.of(context).primaryColor))
                                ]),
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
