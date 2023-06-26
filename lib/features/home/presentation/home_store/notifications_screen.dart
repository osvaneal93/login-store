import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_store_app/features/home/data/models/notification_models.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/notification_item/notification_item.dart';

class NotificationsScreens extends ConsumerWidget {
  static const path = '/notifications';
  const NotificationsScreens({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: () => context.pop(), child: const Icon(Icons.arrow_circle_left_outlined)),
        title: Text(
          'Notifications',
          style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomNotificationItem(
                notificationModel: NotificationModel(
                    notificationId: '1',
                    title: 'Zara',
                    subtitle: 'By 1 Get 1',
                    description:
                        'Get it now! Shop in the App and enjoy buy one, get one 50% off regular price, Offer valid in the app only and you need make a delivery service with us.',
                    imagePath:
                        'https://w7.pngwing.com/pngs/39/910/png-transparent-zara-fashion-clothes-clothing-brands-and-logos-icon.png',
                    dateTime: DateTime.now()),
              ),
              CustomNotificationItem(
                notificationModel: NotificationModel(
                    notificationId: '2',
                    title: 'Zara',
                    subtitle: 'By 1 Get 1',
                    description:
                        'Get it now! Shop in the App and enjoy buy one, get one 50% off regular price, Offer valid in the app only and you need make a delivery service with us.',
                    imagePath:
                        'https://w7.pngwing.com/pngs/39/910/png-transparent-zara-fashion-clothes-clothing-brands-and-logos-icon.png',
                    dateTime: DateTime.now()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
