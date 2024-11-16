import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_update/forgot_pass_update_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class ForgotPasswordUpdatePage extends StatefulWidget {
  static const String routeName = '/forgotPasswordUpdate';

  const ForgotPasswordUpdatePage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordUpdatePageState createState() =>
      _ForgotPasswordUpdatePageState();
}

class _ForgotPasswordUpdatePageState extends State<ForgotPasswordUpdatePage> {
  late ForgotPasswordUpdateController _updateController;
  @override
  void initState() {
    super.initState();
    _updateController = ForgotPasswordUpdateController();
    _updateController.onInit();
  }

  @override
  void dispose() {
    _updateController.dispose();
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
            key: _updateController.formKey,
            autovalidateMode: _updateController.autoValidateMode.value,
            child: Stack(children: [
              Image.asset(
                AppAssets.loginBackground,
                fit: BoxFit.cover,
                width: width,
              ),
              ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      BackButton(),
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
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 69),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).forgotPassword,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          S
                              .of(context)
                              .pleaseEnterNewPasswordConfirmItToResetPassword,
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
                    height: height / 3 - 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
                            labelText: S.of(context).enterNewPassword,
                            prefixIcon: SvgPicture.asset(
                              AppAssets.lockVector,
                              width: 24,
                              color: Get.theme.primaryColor,
                            ),
                            suffixIcon: IconButton(
                                padding: const EdgeInsets.only(bottom: 0),
                                onPressed: () {
                                  setState(() {
                                    _updateController.isActive =
                                        !_updateController.isActive;
                                  });
                                },
                                icon: _updateController.isActive
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          obscureText:
                              _updateController.isActive ? true : false,
                          onChanged: (v) =>
                              _updateController.onNewPasswordSaved(v),
                          onSaved: (v) =>
                              _updateController.onNewPasswordSaved(v),
                          validator: (v) =>
                              AppFormValidators.validateEmpty(v, context),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          decoration:
                              AppDecorations.textFieldDecoration(context)
                                  .copyWith(
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
                                    _updateController.isActive1 =
                                        !_updateController.isActive1;
                                  });
                                },
                                icon: _updateController.isActive1
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                          ),
                          obscureText:
                              _updateController.isActive1 ? true : false,
                          onChanged: (v) =>
                              _updateController.onConfirmPasswordSaved(v),
                          onSaved: (v) =>
                              _updateController.onConfirmPasswordSaved(v),
                          validator: (v) => _updateController
                              .confirmPasswordValidator(v, context),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 18),
                        AppPrimaryButton(
                          key: _updateController.buttonKey,
                          width: Get.width,
                          // padding:
                          //     EdgeInsets.symmetric(horizontal: 128, vertical: 18),
                          onPressed: _updateController.resetPassWord,
                          child: Text(
                            S.of(context).resetPassword,
                            style: const TextStyle(
                              letterSpacing: 0,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
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
