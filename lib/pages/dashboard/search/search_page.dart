import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/dashboard/search/search_controller.dart';
import 'package:my_job_flutter/pages/dashboard/search/widgets/search_history_controller.dart';
import 'package:my_job_flutter/pages/dashboard/search/widgets/search_history_widget.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/widgets/request_card.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/searchPage';
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;
  late SearchController controller = Get.put(SearchController());
  late SearchHistoryController historyController;

  Timer? _debounce;
  final int _debounceTime = 700;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()..addListener(_textChange);
    historyController = Get.put(SearchHistoryController());
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_textChange);
    _textEditingController.dispose();
    super.dispose();
  }

  _textChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () {
      // if (_searchTextController.text != "") {
      ///Search
      _searchQuery = _textEditingController.text.trim();
      controller.getJobSearch(_searchQuery);
      historyController.addToHistory(_searchQuery);
      if (mounted) setState(() {});
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 32,
                  top: 0,
                  child: Image.asset(
                    AppAssets.searchBackgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: 2,
                    // right: 0,
                    // bottom: 32,
                    top: 50,
                    child: Row(
                      children: [
                        const AppBackButton(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        Text(
                          S.of(context).search,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )),
                Positioned(
                    bottom: -2,
                    left: 16,
                    right: 16,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(0.4))
                          ]),
                      child: TextField(
                        controller: _textEditingController,
                        textInputAction: TextInputAction.search,
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.only(left: 16, top: 12),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 12, top: 12),
                              child: SvgPicture.asset(
                                AppAssets.searchIcon,
                                height: 18,
                              ),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                                maxWidth: 70,
                                maxHeight: 70,
                                minHeight: 20,
                                minWidth: 20),
                            hintText: S.of(context).searchForJobs,
                            hintStyle:
                                const TextStyle(color: Color(0xffCBCBCB))),
                      ),
                    ))
              ],
            ),
          ),
          Expanded(
              child: _searchQuery.trim().isEmpty
                  ? SearchHistoryWidget(
                      controller: historyController,
                      onRecentItemClick: (item) {
                        _textEditingController.text = item;
                        // controller.getJobSearch(item);
                        // historyController.addToHistory(item);
                      },
                    )
                  : controller.obx(
                      (state) {
                        if (controller.status.isSuccess && state != null) {
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: controller.status.isLoadingMore
                                  ? state.length + 1
                                  : state.length,
                              itemBuilder: (ctx, i) {
                                if (i >= state.length) {
                                  return const Center(child: AppProgress());
                                }
                                return RequestCard(
                                  data: controller.state![i],
                                );
                              });
                        }
                        return const Center(child: AppProgress());
                      },
                      onError: (e) => AppErrorWidget(
                        title: e ?? S.of(context).someErrorOccurred,
                        onRetry: () {
                          controller.getJobSearch(_searchQuery);
                        },
                      ),
                      onEmpty: AppEmptyWidget(
                        title: S.of(context).noJobsFound,
                        onReload: () {
                          controller.getJobSearch(_searchQuery);
                        },
                      ),
                      onLoading: const Center(child: AppProgress()),
                    ))
        ],
      ),
    );
  }
}
