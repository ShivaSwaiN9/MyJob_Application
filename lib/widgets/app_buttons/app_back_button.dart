import 'package:flutter/material.dart';
import 'package:my_job_flutter/app_configs/app_assets.dart';
import 'package:flutter_svg/svg.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppBackButton extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const AppBackButton({this.color, this.padding, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BackButton(color: color, onPressed: onPressed);
  }
}
