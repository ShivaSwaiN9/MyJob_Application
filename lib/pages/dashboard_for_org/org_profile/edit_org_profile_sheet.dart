import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/app_configs/app_validators.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27/02/2022 7:56 PM
///
class EditProfileSheet extends StatefulWidget {
  const EditProfileSheet({Key? key}) : super(key: key);

  @override
  _EditProfileSheetState createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<AppPrimaryButtonState> _buttonKey = GlobalKey();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _phone;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            const Expanded(
                child: Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )),
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close))
          ],
        ),
        const Divider(height: 0),
        Flexible(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration:
                          AppDecorations.textFieldDecoration(context).copyWith(
                        labelText: S.of(context).enterYourName,
                        prefixIcon: SvgPicture.asset(
                          AppAssets.profileVector,
                          width: 24,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      initialValue: SharedPreferenceHelper.user?.user?.name,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      onSaved: (String? newValue) {
                        _name = newValue!.trim();
                      },
                      validator: (data) =>
                          AppFormValidators.validateEmpty(data, context),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration:
                          AppDecorations.textFieldDecoration(context).copyWith(
                        labelText: S.of(context).phoneNo,
                        prefixIcon: SvgPicture.asset(
                          AppAssets.phoneVector,
                          width: 24,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      initialValue: SharedPreferenceHelper.user?.user?.phone,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onSaved: (String? newValue) {
                        _phone = newValue!.trim();
                      },
                      validator: (data) =>
                          AppFormValidators.validatePhone(data, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: AppPrimaryButton(
                child: const Text('Save'),
                key: _buttonKey,
                onPressed: _updateProfile),
          ),
        )
      ],
    );
  }

  _updateProfile() async {
    final state = _formKey.currentState;
    if (state == null) return;
    if (!state.validate()) {
      setState(() {
        _autovalidateMode = AutovalidateMode.always;
      });
    } else {
      Get.focusScope?.unfocus();
      state.save();
      _buttonKey.currentState?.showLoader();
      try {
        final userController = Get.find<UserController>();
        final res = await AuthHelper.updateUser({
          "phone": _phone,
          "name": _name,
        });

        userController.updateUser(res);
        SnackBarHelper.show("Profile updated.");
        Get.back();
      } catch (err, s) {
        log('$err $s');
        SnackBarHelper.show(err.toString());
      } finally {
        _buttonKey.currentState?.hideLoader();
      }
    }
  }
}
