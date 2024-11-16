import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_job_flutter/generated/l10n.dart';
import 'package:my_job_flutter/pages/notification/notification_controller.dart';
import 'package:my_job_flutter/pages/notification/notification_tile.dart';
import 'package:my_job_flutter/widgets/app_buttons/app_back_button.dart';
import 'package:my_job_flutter/widgets/app_error_widget.dart';
import 'package:my_job_flutter/widgets/app_loader.dart';

class NotificationPage extends GetView<NotificationController> {
  static const routeName = '/notification';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
        leading: const AppBackButton(),
        title: Text(S.of(context).notifications),
      ),
      body: controller.obx(
        (state) {
          if (controller.status.isSuccess && controller.state != null) {
            return RefreshIndicator(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (ctx, i) {
                    return NotificationTile(
                      data: controller.state![i],
                    );
                  },
                  separatorBuilder: (ctx, i) {
                    return const Divider(
                      height: 25,
                    );
                  },
                  itemCount: state!.length),
              onRefresh: () {
                controller.getNotification();
                return Future.delayed(const Duration(seconds: 2));
              },
            );
          }
          return const Center(
            child: AppProgress(),
          );
        },
        onError: (e) => AppErrorWidget(
            title: e ?? S.of(context).someErrorOccurred,
            onRetry: () {
              controller.getNotification();
            }),
        onEmpty: AppEmptyWidget(
          title: S.of(context).noNotificationsFound,
          onReload: () {
            controller.getNotification();
          },
        ),
        onLoading: const Center(child: AppProgress()),
      ),
    );
  }
}
