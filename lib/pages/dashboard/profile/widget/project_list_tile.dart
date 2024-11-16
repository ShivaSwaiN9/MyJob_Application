import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/user.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/profile/widget/project_details_sheet.dart';
import 'package:my_job_flutter/widgets/alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// Created by Sisira Sahoo
/// On 08/07/22 12:55 PM
///

class ProjectListTile extends StatelessWidget {
  final Project datum;
  const ProjectListTile(this.datum, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
        color: Color(0xff9D9D9D), fontSize: 12, fontWeight: FontWeight.w400);
    const textStyle = TextStyle(
        color: Color(0xff2D2D2D), fontSize: 12, fontWeight: FontWeight.w500);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                "Name:",
                style: subTitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                datum.name ?? '',
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Date of Start:",
                style: subTitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('dd.MM.yyyy').format(datum.startDate!),
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Date of End:",
                style: subTitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('dd.MM.yyyy').format(datum.endDate!),
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Description:",
                style: subTitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                datum.description ?? '',
                style: textStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                "Link:",
                style: subTitleStyle,
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  launch(datum.link!);
                },
                child: const Text(
                  "View Project",
                  style: const TextStyle(
                      color: Color(0xff0A7BE7),
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showAppAlertDialog(
                          title: "Delete",
                          description: "Are you sure want to delete project?")
                      .then((value) {
                    if (value == true) {
                      final controller = Get.find<UserController>();
                      controller.deleteProject(datum);
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
                      "Delete Project",
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
                  Get.bottomSheet(
                      ProjectDetailsSheet(
                        datum: datum,
                      ),
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
                      "Edit Project",
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
