import 'package:my_job_flutter/pages/authenticaton/forgot_pass/forgot_pass_page.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_otp/forgot_pass_otp_page.dart';
import 'package:my_job_flutter/pages/authenticaton/forgot_pass_update/forgot_pass_update.dart';
import 'package:my_job_flutter/pages/authenticaton/new_phone/new_phone_login_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_details/register_for_job_seeker_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_options/register_options_page.dart';
import 'package:my_job_flutter/pages/authenticaton/register_organization/register_organization_page.dart';
import 'package:my_job_flutter/pages/cancel_subscription/cancel_subscription_page.dart';
import 'package:my_job_flutter/pages/coupon/coupon_page.dart';
import 'package:my_job_flutter/pages/dashboard/Featured_job/featured_job_binding.dart';
import 'package:my_job_flutter/pages/dashboard/Featured_job/featured_job_page.dart';
import 'package:my_job_flutter/pages/dashboard/bindings/dashboard_binding.dart';
import 'package:my_job_flutter/pages/dashboard/blog_details_page.dart';
import 'package:my_job_flutter/pages/dashboard/dashboard_page.dart';
import 'package:my_job_flutter/pages/dashboard/my_applications/my_applications_page.dart';
import 'package:my_job_flutter/pages/dashboard/profile/profile_page.dart';
import 'package:my_job_flutter/pages/dashboard/recommended_jobs/recommended_jobs_page.dart';
import 'package:my_job_flutter/pages/dashboard/recommended_jobs/recommended_page_binding.dart';
import 'package:my_job_flutter/pages/dashboard/referral/referral_page.dart';
import 'package:my_job_flutter/pages/dashboard/search/search_page.dart';
import 'package:my_job_flutter/pages/dashboard/success/success_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/bindings/dashboard_for_org_binding.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/dashboard_for_org_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/org_profile/org_profile_page.dart';
import 'package:my_job_flutter/pages/dashboard_for_org/request_detail/request_detail_page.dart';
import 'package:my_job_flutter/pages/language_choose_page/lanuage_choose_page.dart';
import 'package:my_job_flutter/pages/notification/notification_binding.dart';
import 'package:my_job_flutter/pages/notification/notification_page.dart';
import 'package:my_job_flutter/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/pages/subscription/subscription_page.dart';
import 'package:my_job_flutter/pages/subscription_org/subscription_org_page.dart';
import 'package:my_job_flutter/pages/view_jobs/view_jobs_page.dart';

import '../pages/dashboard/my_applications/my_applications_page_binding.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  /// NOT TO BE USE NOW
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
    GetPage(
        name: LanguageChoosePage.routeName,
        page: () => const LanguageChoosePage()),
    // GetPage(name: LoginPage.routeName, page: () => const LoginPage()),
    GetPage(
        name: ForgotPasswordPage.routeName,
        page: () => const ForgotPasswordPage()),
    GetPage(name: NewPhonePage.routeName, page: () => const NewPhonePage()),
    GetPage(
        name: ForgotPassOtpPage.routeName,
        page: () => const ForgotPassOtpPage()),
    GetPage(
        name: SubscriptionOrgPage.routeName,
        page: () => const SubscriptionOrgPage()),
    GetPage(
        name: ForgotPasswordUpdatePage.routeName,
        page: () => const ForgotPasswordUpdatePage()),
    GetPage(
        name: RegisterForJobSeekerPage.routeName,
        page: () => const RegisterForJobSeekerPage()),
    GetPage(
        name: RegisterForOrganizationPage.routeName,
        page: () => const RegisterForOrganizationPage()),
    GetPage(
        name: RegisterOptionsPage.routeName,
        page: () => const RegisterOptionsPage()),
    GetPage(
      name: DashboardPage.routeName,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      children: [
        GetPage(
            name: BlogDetailsPage.routeName,
            page: () => const BlogDetailsPage()),
        GetPage(
            name: CancelSubscriptionPage.routeName,
            page: () => const CancelSubscriptionPage()),
        GetPage(
            name: SubscriptionPage.routeName,
            page: () => const SubscriptionPage()),
        GetPage(name: SuccessPage.routeName, page: () => const SuccessPage()),
        GetPage(name: SearchPage.routeName, page: () => const SearchPage()),
        GetPage(
            name: FeaturedJobPage.routeName,
            binding: FeaturedJobBinding(),
            page: () => const FeaturedJobPage()),
        GetPage(name: ViewJobsPage.routeName, page: () => const ViewJobsPage()),
        GetPage(
            name: RecommendedJobsPage.routeName,
            binding: RecommendedPageBinding(),
            page: () => const RecommendedJobsPage()),
        GetPage(
            name: MyApplicationsPage.routeName,
            binding: MyApplicationsPageBinding(),
            page: () => const MyApplicationsPage()),
        GetPage(name: CouponPage.routeName, page: () => const CouponPage()),
        GetPage(
            name: NotificationPage.routeName,
            page: () => const NotificationPage(),
            binding: NotificationBinding()),
        GetPage(name: ReferralPage.routeName, page: () => const ReferralPage()),
        GetPage(name: ProfilePage.routeName, page: () => const ProfilePage()),
      ],
    ),
    GetPage(
      name: DashboardForOrgPage.routeName,
      page: () => const DashboardForOrgPage(),
      binding: DashboardForOrgBinding(),
      children: [
        GetPage(
            name: RequestDetailPage.routeName,
            page: () => const RequestDetailPage()),
        GetPage(name: OrgProfile.routeName, page: () => const OrgProfile()),
      ],
    ),
  ];
}
