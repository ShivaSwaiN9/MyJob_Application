///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment = "dev";
  // String.fromEnvironment("env", defaultValue: 'prod');

  static const String baseApiUrl = environment == 'dev'
      ? 'http://192.168.29.241:3030'
      : 'https://api.myjobservices.in';

  /// 'https://api.test.myjobservices.in'
  static const fontFamily = 'Poppins';
  static const razorPayName = "My job";

  static const razorPayKey = environment == 'prod'
      ? 'rzp_live_NXkyTLQS4vTwwc'
      : 'rzp_test_wiS864jfTomrOZ';

  static const razorPayKeySecret = 'RDgDRqnLU0JdfFjV5ZO6JTWc';
}
