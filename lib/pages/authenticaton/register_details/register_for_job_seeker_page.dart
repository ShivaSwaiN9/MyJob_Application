import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/new_register_details_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

class RegisterForJobSeekerPage extends StatefulWidget {
  static const String routeName = '/registerDetails';

  const RegisterForJobSeekerPage({Key? key}) : super(key: key);

  @override
  _RegisterForJobSeekerPageState createState() =>
      _RegisterForJobSeekerPageState();
}

class _RegisterForJobSeekerPageState extends State<RegisterForJobSeekerPage> {
  late NewRegisterDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NewRegisterDetailsController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<NewRegisterDetailsController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Obx(
          () => GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidateMode.value,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: const [
                      AppBackButton(),
                    ],
                  ),
                  SvgPicture.asset(AppAssets.orgOnboardVector),
                  const SizedBox(height: 30),
                  Text(
                    'Enter your details',
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
                    'Tell us your informations which will be\nused for your profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffACACAC),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      labelText: S.of(context).enterYourName,
                      prefixIcon: SvgPicture.asset(
                        AppAssets.profileVector,
                        width: 18,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    initialValue: controller.name,
                    onSaved: (v) => controller.onNameSaved(v),
                    validator: (v) =>
                        AppFormValidators.validateEmpty(v, context),
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      labelText: S.of(context).enterEmailIdoptional,
                      prefixIcon: SvgPicture.asset(
                        AppAssets.messageVector,
                        width: 19,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    // initialValue: controller.phone,
                    onSaved: (v) => controller.onEmailSaved(v),
                    validator: (v) => controller.validateMail(v, context),
                    textCapitalization: TextCapitalization.none,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: Get.height / 6,
                  ),
                  AppPrimaryButton(
                      key: controller.buttonKey,
                      child: Text(S.of(context).signup),
                      onPressed: controller.completeStep)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
