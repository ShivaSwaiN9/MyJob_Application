import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_details_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_org_controller.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/widgets/onboard_name_detail.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/widgets/upload_dp.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';

class RegisterForOrganizationPage extends StatefulWidget {
  static const String routeName = '/registerOrganization';

  const RegisterForOrganizationPage({Key? key}) : super(key: key);

  @override
  _RegisterForOrganizationPageState createState() =>
      _RegisterForOrganizationPageState();
}

class _RegisterForOrganizationPageState
    extends State<RegisterForOrganizationPage> {
  late RegisterOrgController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(RegisterOrgController());
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<RegisterDetailsController>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: _controller.wilPopScope,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    AppBackButton(onPressed: () {
                      _controller.wilPopScope().then((value) {
                        if (value) {
                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : exit(0);
                        }
                      });
                    }),
                    const Spacer(),
                    Obx(
                      () => Text(
                        "${S.of(context).step}"
                        ' ${_controller.currentPage.value + 1}/2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: theme.primaryColor,
                            letterSpacing: 0.6),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Expanded(
                  flex: 3,
                  child: PageView(
                    controller: _controller.pageController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: _controller.onPageChange,
                    children: [
                      OnboardName(_controller),
                      // OnboardEmail(_controller),
                      UploadDp(_controller),
                    ],
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
