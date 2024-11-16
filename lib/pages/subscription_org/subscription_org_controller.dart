import 'dart:developer' as d;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_job_flutter/api_services/base_api.dart';
import 'package:my_job_flutter/app_configs/api_routes.dart';
import 'package:my_job_flutter/app_configs/environment.dart';
import 'package:my_job_flutter/data_models/coupon_dm.dart';
import 'package:my_job_flutter/data_models/plan_dm.dart';
import 'package:my_job_flutter/data_models/subscription_dm.dart';
import 'package:my_job_flutter/global_controllers/user_controller.dart';
import 'package:my_job_flutter/pages/dashboard/controllers/plan_controller.dart';
import 'package:my_job_flutter/pages/dashboard/success/success_page.dart';
import 'package:my_job_flutter/utils/shared_preference_helper.dart';
import 'package:my_job_flutter/utils/snackbar_helper.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_primary_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

///
/// Created by Sisira Sahoo
/// On 20/07/22 12:57 PM
///

class SubscriptionOrgController extends GetxController {
  CouponDatum? selectedCoupon;
  final UserController userController;
  SubscriptionOrgController(this.userController);
  late PlanController planController;
  late List<ProductDetails> products;
  final Razorpay _razorpay = Razorpay();
  String? razorPayPaymentId;
  Map<String, dynamic>? razorPayOptions;
  bool? isSignup;
  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic>? map = Get.arguments;
    if (map != null) {
      isSignup = map["isSignup"];
    }
    planController = Get.isRegistered<PlanController>()
        ? Get.find<PlanController>()
        : Get.put(PlanController());
    if (Platform.isAndroid) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    } else if (Platform.isIOS) {
      initInAppPurchase();
    }
  }

  final GlobalKey<AppPrimaryButtonState> buttonKey = GlobalKey();

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  initInAppPurchase() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      print('In App Purchase not available');
    } else {
      const Set<String> _kIds = <String>{'com.myjob.user.proOrg'};
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        print('Some not found ids found');
      } else {
        products = response.productDetails;
      }
      InAppPurchase.instance.restorePurchases();

      InAppPurchase.instance.purchaseStream.listen((event) async {
        // print("HELU${event}");
        if (event.isEmpty) return;
        d.log(
            "STREAM ${event.length} ${event.first.status} ${event.last.status}");

        switch (event.first.status) {
          case PurchaseStatus.pending:
            // await InAppPurchase.instance.completePurchase(event.first);
            break;
          case PurchaseStatus.purchased:
            await InAppPurchase.instance
                .completePurchase(event.first)
                .then((value) => _handlePaymentSuccess);
            break;

          case PurchaseStatus.restored:
            _handlePaymentSuccess;
            break;
          case PurchaseStatus.error:
          case PurchaseStatus.canceled:
            SnackBarHelper.show(event.first.error?.message ?? '');
            await InAppPurchase.instance.completePurchase(event.first);
            buttonKey.currentState?.hideLoader();
            break;
        }
      });
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    razorPayPaymentId = response.paymentId;
    userController.updateSubscriptionStatus(1);
    Get.offNamed(SuccessPage.routeName);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    buttonKey.currentState?.hideLoader();
    if (response.code == Razorpay.PAYMENT_CANCELLED) {
      // loadingText = 'Payment cancelled.';
      SnackBarHelper.show("Premium payment failed");
    } else if (response.code == Razorpay.NETWORK_ERROR) {
      // loadingText = 'No internet connection.';
      SnackBarHelper.show("No internet connection");
    } else {
      SnackBarHelper.show(response.message ?? "Some error occured");
      d.log("${response.message}");
    }
  }

  completeBooking() async {
    try {
      buttonKey.currentState?.showLoader();
      print("plana${planController.state![1].id}");
      final result = await ApiCall.post(ApiRoutes.createSubscription, body: {
        "subscriptionPlanId": planController.state![1].id,
        // "subscriptionPlanId": "62cdb5e1667f7b442b317950",
        if (selectedCoupon != null) "coupon": selectedCoupon?.id
      });
      d.log("#${result.data}");
      final response = SubscriptionDatum.fromJson(result.data);
      if (Platform.isAndroid) {
        razorPayOptions = {
          'key': Environment.razorPayKey,
          'order_id': response.razorpayOrderId,
          'name': Environment.razorPayName,
          // 'description': 'Demo desc',
          'prefill': {
            'contact':
                '91' + ((SharedPreferenceHelper.user?.user?.phone) ?? ""),
            'email': SharedPreferenceHelper.user?.user?.email,
          },
          'notes': {
            'name': SharedPreferenceHelper.user?.user?.name,
            'createdBy': SharedPreferenceHelper.user?.user?.id,
            "paymentId": response.razorpayOrderId,
          }
        };
      } else if (Platform.isIOS) {
        /// In app purchase
        await InAppPurchase.instance.buyConsumable(
            purchaseParam: PurchaseParam(productDetails: products[0]),
            autoConsume: true);
      }

      _razorpay.open(razorPayOptions!);
    } catch (e, s) {
      buttonKey.currentState?.hideLoader();
      print("complte log ${e.toString()}");
      d.log("_completeBooking ${e.toString()}", error: e, stackTrace: s);
    }
  }

//   _completePayment() async {
//     await ApiCall.patch(ApiRoutes.createSubscription,
//             id: state.id!, body: {"paymentId": razorPayPaymentId})
//         .then((value) => Get.toNamed(BookingSuccessPage.routeName))
//         .catchError((e) {
//       log("_completePayment error", error: e);
//     }).whenComplete(() => _buttonKey.currentState?.hideLoader());
//   }
  updateSelectedCoupon(CouponDatum? coupon) {
    selectedCoupon = coupon;
    update([0]);
  }

  double getDiscountPrice(CouponDatum coupon, PlanDatum selectedPlan) {
    double res = selectedPlan.price!;
    if (coupon.type == 2) {
      res = res - coupon.discount!;
    } else {
      res = selectedPlan.price! -
          (selectedPlan.price! * (coupon.discount! / 100));
    }
    return res;
  }
}
