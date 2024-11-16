import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_for_job_seeker_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_organization_page.dart';

class RegisterOptionsPage extends StatefulWidget {
  static const routeName = '/registerOptionsPage';
  const RegisterOptionsPage({Key? key}) : super(key: key);

  @override
  State<RegisterOptionsPage> createState() => _RegisterOptionsPageState();
}

class _RegisterOptionsPageState extends State<RegisterOptionsPage> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double width = Get.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SvgPicture.asset(
              AppAssets.optionVector,
              width: width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 15),
            child: Text(S.of(context).registerNowToncontinue,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff2F415E))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              S.of(context).pleaseSpecifyTheUserTypeToProceed,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffACACAC)),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                    child: SelectedCard(
                        name: S.of(context).jobSeeker,
                        icon: AppAssets.jobSeeker,
                        onTap: () {
                          Get.toNamed(RegisterForJobSeekerPage.routeName);
                        })),
                const SizedBox(width: 14),
                Expanded(
                  child: SelectedCard(
                    name: S.of(context).organization,
                    onTap: () {
                      Get.toNamed(RegisterForOrganizationPage.routeName);
                    },
                    icon: AppAssets.orgIcon,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}

class SelectedCard extends StatelessWidget {
  VoidCallback onTap;
  String icon;
  String name;
  SelectedCard(
      {required this.name, required this.icon, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        // width: 63,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xffD7D7D7), width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 12, color: Color(0xff545454)),
            )
          ],
        ),
      ),
    );
  }
}
