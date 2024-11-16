import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/search/widgets/search_history_controller.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget(
      {this.onRecentItemClick, Key? key, required this.controller})
      : super(key: key);
  final Function(String item)? onRecentItemClick;
  final SearchHistoryController controller;
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) {
        if (state == null || state.isEmpty) {
          return SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppAssets.emptySearchVector),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    S.of(context).noHistoryFound,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    S.of(context).pleaseSearchSomething,
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xff858585)),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                children: [
                  SvgPicture.asset(AppAssets.recentSearchIcon),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    S.of(context).recentSearches,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: Environment.fontFamily),
                  ),
                  // const Spacer(),
                  // const Text(
                  //   "Clear all",
                  //   style: TextStyle(
                  //       color: Colors.red,
                  //       fontWeight: FontWeight.w500,
                  //       fontFamily: Environment.fontFamily),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: state.length,
                separatorBuilder: (c, i) => const Divider(height: 25),
                itemBuilder: (c, i) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    onRecentItemClick?.call(state[i]);
                  },
                  title: Text(
                    state[i],
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  trailing: IconButton(
                      onPressed: () => controller.removeHistory(state[i]),
                      icon: const Icon(Icons.clear)),
                ),
              ),
            ),
          ],
        );
      },
      onEmpty: SizedBox(
        height: 200,
        child: AppErrorWidget(
          title: S.of(context).typeSomethingToSearch,
        ),
      ),
    );
  }
}
