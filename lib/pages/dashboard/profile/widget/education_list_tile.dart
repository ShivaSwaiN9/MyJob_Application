import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/education_details_sheet.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';

///
/// Created by Sisira Sahoo
/// On 07/07/22 1:57 PM
///
class EducationListTile extends StatelessWidget {
  final Education education;
  const EducationListTile({Key? key, required this.education})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
        color: Color(0xff9D9D9D), fontSize: 12, fontWeight: FontWeight.w400);
    const textStyle = TextStyle(
        color: Color(0xff2D2D2D), fontSize: 12, fontWeight: FontWeight.w500);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).highestEducation, style: subTitleStyle),
                const SizedBox(height: 5),
                Text(
                  education.highestEducation ?? "",
                  style: textStyle,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffF2F2F2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).yearOfPassing,
                    style: TextStyle(
                        fontSize: 12, height: 1.4, color: Color(0xff2D9AFF))),
                Text(education.yearOfPassing ?? "",
                    style: TextStyle(
                        color: Color(0xff130F26), fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Text(S.of(context).course, style: subTitleStyle),
      const SizedBox(height: 6),
      Text(education.course ?? "", style: textStyle),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).university, style: subTitleStyle),
                const SizedBox(height: 6),
                Text(education.university ?? "", style: textStyle),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                Get.bottomSheet(EducationDetailsSheet(data: education),
                    isScrollControlled: true);
              },
              icon: SvgPicture.asset(
                AppAssets.edit,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                showAppAlertDialog(
                        title: "Delete",
                        description: "Are you sure want to delete education?")
                    .then((value) {
                  if (value == true) {
                    final controller = Get.find<UserController>();
                    controller.deleteEducation(education);
                  }
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    ]);
  }
}
