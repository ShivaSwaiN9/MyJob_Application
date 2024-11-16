import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_controller.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sisira Sahoo
/// On 16/04/22 5:08 PM
///

class NewPhonePage extends StatefulWidget {
  static const routeName = '/newPhonePage';

  const NewPhonePage({Key? key}) : super(key: key);

  @override
  State<NewPhonePage> createState() => _NewPhonePageState();
}

class _NewPhonePageState extends State<NewPhonePage> {
  late NewLoginPhoneController controller;

  @override
  void initState() {
    super.initState();
    controller = NewLoginPhoneController()..onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double width = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: controller.formKey,
            autovalidateMode: controller.autoValidateMode.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    AppAssets.phoneLoginBackground,
                    width: width,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: Text(S.of(context).loginNowToContinue,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff2F415E))),
                ),
                // const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration:
                        AppDecorations.textFieldDecoration(context).copyWith(
                      labelText: S.of(context).enterPhoneNo,
                      prefixIcon: SvgPicture.asset(
                        AppAssets.phoneIcon,
                        width: 24,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    validator: (v) =>
                        AppFormValidators.validatePhone(v, context),
                    keyboardType: TextInputType.phone,
                    onSaved: (v) => controller.onPhoneSaved(v),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppPrimaryButton(
                    key: controller.buttonKey,
                    width: Get.width,
                    onPressed: controller.loginPhoneNumber,
                    child: Text(
                      S.of(context).next,
                      style: const TextStyle(
                        letterSpacing: 0,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (controller.isLoginFromStart) const SizedBox(height: 10),
                if (!controller.isLoginFromStart)
                  Center(
                    child: TextButton(
                      onPressed: controller.onSkipForNowPressed,
                      child: const Text(
                        "Skip for Now",
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
