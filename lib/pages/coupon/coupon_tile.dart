import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/data_models/coupon_dm.dart';
import 'package:my_job_flutter/pages/coupon/coupon_controller.dart';
import 'package:my_job_flutter/utils/common_functions.dart';

class CouponTile extends StatelessWidget {
  final CouponDatum state;
  const CouponTile(this.state, {this.onTap, Key? key}) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final couponController = Get.find<CouponController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffD9D9D9)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  AppAssets.couponCard,
                  // fit: BoxFit.cover,
                  width: Get.width,
                  alignment: Alignment.topCenter,
                  color: const Color(0xffB3D6F8),
                ),
                Positioned(
                  top: 16,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: state.type == 1
                                  ? '${formatPercentage(state.discount!)}% '
                                  : "${formatPrice(state.discount!)} ",
                              style: const TextStyle(
                                  color: Color(0xff0F3C66),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                              children: [
                            const TextSpan(
                                text: 'Off',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400))
                          ])),
                      const SizedBox(
                        height: 10,
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(13, 4, 13, 4),
                          child: Text(
                            "${state.code}".toUpperCase(),
                            style: const TextStyle(
                                color: Color(0xff0A7BE7),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "${state.title}",
              textAlign: TextAlign.start,
              style: const TextStyle(color: Color(0xff898989), fontSize: 10),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: couponController.couponDatum?.id == state.id ? () {} : onTap,
            child: Container(
              width: Get.width,
              height: 40,
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
                color: couponController.couponDatum?.id == state.id
                    ? const Color(0xffCEDDAE)
                    : const Color(0xff3C3C3C),
              ),
              child: Center(
                  child: Text(
                couponController.couponDatum?.id == state.id
                    ? "Applied"
                    : "Apply coupon",
                style: TextStyle(
                    color: couponController.couponDatum?.id == state.id
                        ? const Color(0xff6F785A)
                        : Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
