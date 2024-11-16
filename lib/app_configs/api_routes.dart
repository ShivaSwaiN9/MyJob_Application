import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const upload = 'upload';
  static const job = 'v1/master-job';
  static String authenticateJwt = 'authentication';
  static const blog = 'v1/blog';
  static const employeeRequest = 'v1/employee-request';
  static const employeeRequestApplicant = 'v1/employee-request-application';
  static const activeJobs = 'v1/active-jobs';
  static const notification = 'v1/notification';
  static const master = 'v1/master';
  static const banner = 'v1/banner';
  static const user = 'v1/user';
  static const authenticatePhone = 'v1/authenticate-phone';
  static const cancelSub = 'v1/cancel-subscription';
  static const subscriptionPlan = 'v1/subscription-plan';
  static const createSubscription = 'v1/create-subscription';
  static const coupon = 'v1/coupon';
}
