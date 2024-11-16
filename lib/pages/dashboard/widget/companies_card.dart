import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/top_companies_dm.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/view_jobs/view_jobs_page.dart';
import 'package:my_job_flutter/widgets/user_circle_avatar.dart';

class CompaniesCard extends StatelessWidget {
  final TopCompaniesDatum state;
  const CompaniesCard({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160,
          // padding: const EdgeInsets.fromLTRB(17, 17, 17, 11),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              border: Border.all(color: const Color(0xffEBEBEB), width: 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              UserCircleAvatar(state.avatar, name: state.companyName),
              const SizedBox(
                height: 11,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.companyName ?? '',
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(ViewJobsPage.routeName,
                arguments: {"id": state.id, "name": state.companyName});
          },
          child: Container(
            height: 40,
            width: 160,
            decoration: BoxDecoration(
                color: Get.theme.primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      color: const Color(0xff122641).withOpacity(.27),
                      blurRadius: 5)
                ]),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).viewJobs,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: Environment.fontFamily,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
