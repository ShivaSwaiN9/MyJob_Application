import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/employement_details_sheet.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';

///
/// Created by Sisira Sahoo
/// On 07/07/22 5:20 PM
///
class EmploymentListTile extends StatelessWidget {
  final Employment employment;
  const EmploymentListTile({Key? key, required this.employment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
        color: Color(0xff9D9D9D), fontSize: 12, fontWeight: FontWeight.w400);
    const textStyle = TextStyle(
        color: Color(0xff2D2D2D), fontSize: 12, fontWeight: FontWeight.w500);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).organisation, style: subTitleStyle),
        const SizedBox(height: 5),
        Text(
          employment.organisation ?? "",
          style: textStyle,
        ),
        const SizedBox(height: 10),
        Text(S.of(context).designation, style: subTitleStyle),
        const SizedBox(height: 6),
        Text(employment.designation ?? "", style: textStyle),
        const SizedBox(height: 10),
        Text(S.of(context).duration, style: subTitleStyle),
        const SizedBox(height: 6),
        Text(employment.durationString(context), style: textStyle),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).responsibility, style: subTitleStyle),
                  const SizedBox(height: 6),
                  Text(employment.responsibility ?? "", style: textStyle),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showAppAlertDialog(
                          title: "Delete",
                          description:
                              "Are you sure want to delete employment?")
                      .then((value) {
                    if (value == true) {
                      final controller = Get.find<UserController>();
                      controller.deleteEmployment(employment);
                    }
                  });
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                      // color: const Color(0xffDFF0FF),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xffACACAC))),
                  child: const Center(
                    child: Text(
                      "Delete Details",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(EmploymentDetailsSheet(data: employment),
                      isScrollControlled: true);
                },
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFF0FF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      "Edit Details",
                      style: TextStyle(color: Color(0xff0A7BE7)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
