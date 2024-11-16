///
/// Created by Sisira Sahoo
/// On 10/05/22 4:14 PM
///

import 'dart:convert';

import 'package:my_job_flutter/data_models/coupon_dm.dart';

SubscriptionDatum subscriptionDatumFromJson(String str) =>
    SubscriptionDatum.fromJson(json.decode(str));

String subscriptionDatumToJson(SubscriptionDatum data) =>
    json.encode(data.toJson());

class SubscriptionDatum {
  SubscriptionDatum({
    this.subscriptionPlanId,
    this.coupon,
    this.createdBy,
    this.couponData,
    this.price,
    this.discount,
    this.finalPrice,
    this.razorpayOrderId,
  });

  String? subscriptionPlanId;
  String? coupon;
  String? createdBy;
  CouponDatum? couponData;
  double? price;
  double? discount;
  double? finalPrice;
  String? razorpayOrderId;

  factory SubscriptionDatum.fromJson(Map<String, dynamic> json) =>
      SubscriptionDatum(
        subscriptionPlanId: json["subscriptionPlanId"] ?? '',
        coupon: json["coupon"] ?? '',
        createdBy: json["createdBy"] ?? '',
        couponData: json["couponData"] == null
            ? null
            : CouponDatum.fromJson(json["couponData"]),
        price: (json["price"] ?? 0).toDouble(),
        discount: (json["discount"] ?? 0).toDouble(),
        finalPrice: (json["finalPrice"] ?? 0).toDouble(),
        razorpayOrderId: json["razorpayOrderId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "subscriptionPlanId": subscriptionPlanId,
        "coupon": coupon,
        "createdBy": createdBy,
        "couponData": couponData?.toJson(),
        "price": price,
        "discount": discount,
        "finalPrice": finalPrice,
        "razorpayOrderId": razorpayOrderId,
      };
}
