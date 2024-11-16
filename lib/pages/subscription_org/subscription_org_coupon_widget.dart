import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_controller.dart';
import 'package:my_job_flutter/utils/common_functions.dart';

///
/// Created by Sisira Sahoo
/// On 20/07/22 1:55 PM
///

class SubscriptionOrgCouponWidget extends StatelessWidget {
  final VoidCallback? onTap, onDelete;
  const SubscriptionOrgCouponWidget({Key? key, this.onTap, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubscriptionOrgController>(
        id: 0,
        builder: (controller) {
          return GestureDetector(
            onTap: onTap,
            child: Material(
              color: controller.selectedCoupon == null
                  ? const Color(0xff465971)
                  : const Color(0xff0D2542),
              borderRadius: BorderRadius.circular(15),
              child: controller.selectedCoupon == null
                  ? ListTile(
                      leading: SvgPicture.asset(AppAssets.discountIcon),
                      title: const Text(
                        "Apply Coupon",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.appliedIcon),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: RichText(
                                text: TextSpan(
                                    text: '${controller.selectedCoupon?.code}'
                                        .toUpperCase(),
                                    style: TextStyle(
                                        height: 1.3,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                    children: [
                                  TextSpan(
                                    text: " Applied.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  TextSpan(
                                    text: "\nAdd/ Change coupon",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xffFFCB7D)),
                                  ),
                                  TextSpan(
                                    text: controller.selectedCoupon!.type == 1
                                        ? "\n${formatPercentage(controller.selectedCoupon!.discount!)}% Off (You save ₹${controller.getDiscountPrice(controller.selectedCoupon!, controller.planController.state![1])})"
                                        : "\n${formatPrice(controller.selectedCoupon!.discount!)} Off (You save ₹${controller.getDiscountPrice(controller.selectedCoupon!, controller.planController.state![1])})",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  )
                                ])),
                          ),
                          CloseButton(
                            onPressed: onDelete,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
            ),
          );
        });
  }
}
