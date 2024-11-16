import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 20-01-2022 10:40 AM
///
class LanguageChoosePage extends StatefulWidget {
  static const routeName = "/languageChoose";
  const LanguageChoosePage({Key? key}) : super(key: key);

  @override
  _LanguageChoosePageState createState() => _LanguageChoosePageState();
}

class _LanguageChoosePageState extends State<LanguageChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const SizedBox(height: 22),
              Text(
                S.of(context).chooseYourLanguage,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Row(
                children: const [
                  Expanded(
                      child: LanguageTile(
                          title: "Aa", language: "English", code: "en")),
                  SizedBox(width: 22),
                  Expanded(
                      child: LanguageTile(
                          title: "ଆ", language: "Odia", code: "or_IN")),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile(
      {Key? key,
      required this.code,
      required this.title,
      required this.language})
      : super(key: key);
  final String code, language, title;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: 2,
            color: Get.theme.primaryColor,
          )),
      child: InkWell(
        onTap: () {
          SharedPreferenceHelper.storeLocale(code);
          AuthHelper.checkUserLevel();
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Text(
                  language,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
