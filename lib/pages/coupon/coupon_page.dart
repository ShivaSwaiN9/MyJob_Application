import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/app_configs/app_decorations.dart';
import 'package:my_job_flutter/pages/coupon/coupon_controller.dart';
import 'package:my_job_flutter/pages/coupon/coupon_tile.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class CouponPage extends StatefulWidget {
  static const routeName = '/coupon';
  const CouponPage({Key? key}) : super(key: key);

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late TextEditingController _textEditingController;
  Timer? _debounce;
  final int _debounceTime = 700;
  late CouponController controller;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController()..addListener(_textChange);
    controller = Get.put(CouponController());
  }

  _textChange() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debounceTime), () {
      // if (_searchTextController.text != "") {
      ///Search
      controller.searchQuery = _textEditingController.text.trim();
      setState(() {});
      // }
    });
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_textChange);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 120,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Image.asset(
                    AppAssets.searchBackgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: 2,
                    // right: 0,
                    bottom: 25,
                    // top: 50,
                    child: Row(
                      children: const [
                        AppBackButton(
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Text(
                          "Add/Change coupon",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              controller: _textEditingController,
              decoration: AppDecorations.textFieldDecoration(context).copyWith(
                  hintText: "Enter coupon code",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Icon(Icons.search),
                  ),
                  suffixIcon: controller.searchQuery.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _textEditingController.clear();
                          },
                        )),
            ),
          ),
          Expanded(
              child: controller.obx((state) {
            if (controller.status.isSuccess && controller.state != null) {
              return RefreshIndicator(
                onRefresh: () {
                  controller.getCoupon(controller.searchQuery);
                  return Future.delayed(const Duration(seconds: 2));
                },
                child: GridView.builder(
                    controller: controller.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.70,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.shouldLoadMore
                        ? state!.length + 1
                        : state!.length,
                    itemBuilder: (ctx, i) {
                      if (i >= state.length) {
                        return const Center(child: AppProgress());
                      }
                      return CouponTile(
                        state[i],
                        onTap: () {
                          Get.back(result: state[i]);
                        },
                      );
                    }),
              );
            } else {
              return const Center(child: AppProgress());
            }
          },
                  onLoading: const Center(child: AppProgress()),
                  onEmpty: const AppEmptyWidget(
                    title: "No coupons found",
                  )))
        ],
      ),
    );
  }
}
