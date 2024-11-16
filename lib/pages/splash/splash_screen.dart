import 'package:flutter/material.dart';
import 'package:my_job_flutter/utils/app_auth_helper.dart';

/// SplashPage for handling splash screen logic
class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Remove null-aware operator as WidgetsBinding.instance is non-nullable
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Handle async logic within the frame callback
      await AuthHelper.refreshAccessToken();
      AuthHelper.checkUserLevel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0072ff),
      body: Center(
        child: Image.asset(
          'assets/icons/splash_logo.png',
          height: 80,
        ),
      ),
    );
  }
}
