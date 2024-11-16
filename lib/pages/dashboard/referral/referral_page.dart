import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:share_plus/share_plus.dart';

class ReferralPage extends StatefulWidget {
  static const routeName = '/referralPage';
  const ReferralPage({Key? key}) : super(key: key);

  @override
  State<ReferralPage> createState() => _ReferralPageState();
}

class _ReferralPageState extends State<ReferralPage> {
  late String referCode;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic>? map = Get.arguments;
    if (map != null) {
      referCode = map['state'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                AppAssets.referBanner,
                fit: BoxFit.cover,
                width: Get.width,
                // height: Get.height / 3 + ,
              ),
              const Positioned(
                  child: SafeArea(
                child: AppBackButton(
                  color: Colors.white,
                ),
              )),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          S.of(context).referAndEarn,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        S
                            .of(context)
                            .introduceMyjobToYourFriendsFamilyColleaguesAndGetA,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Text(
              S.of(context).howItWorks,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset(
              AppAssets.howItWork,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              S.of(context).yourReferralCode,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          InkWell(
            onTap: () {
              Clipboard.setData(ClipboardData(text: referCode));
              SnackBarHelper.show(S.of(context).codeCopiedToClipboard);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xff828282).withOpacity(0.30)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    referCode,
                    style: const TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    S.of(context).tapToCopy,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: AppPrimaryButton(
            onPressed: () {
              Share.share(referCode);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: SvgPicture.asset(
                    AppAssets.shareIcon,
                    color: Colors.white,
                    height: 18,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  S.of(context).share,
                  style: const TextStyle(letterSpacing: 0),
                ),
              ],
            )),
      ),
    );
  }
}
