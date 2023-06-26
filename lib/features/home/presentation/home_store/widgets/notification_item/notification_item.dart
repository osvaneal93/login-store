import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/features/home/data/models/notification_models.dart';
import 'package:multi_store_app/features/home/presentation/home_store/widgets/deliver_item/delivery_custom_painter_item.dart';

class CustomNotificationItem extends ConsumerWidget {
  final NotificationModel notificationModel;
  final void Function()? onTap;
  final void Function(DismissDirection)? onDismissed;

  const CustomNotificationItem({super.key, required this.notificationModel, this.onTap, this.onDismissed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Dismissible(
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: screenSize.height * .2,
        width: screenSize.width * .9,
        child: CustomPaint(
          painter: CurvedRectanglePainter(
            borderColor: Colors.transparent,
            backgroundColor: Colors.green.shade200,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                child: const Icon(
                  Icons.check_box,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.5),
              ),
            ),
          ),
        ),
      ),
      key: Key(notificationModel.notificationId ?? ''),
      onDismissed: onDismissed,
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: screenSize.height * .2,
        width: screenSize.width * .9,
        child: CustomPaint(
          painter: CurvedRectanglePainter(
            borderColor: Colors.transparent,
            backgroundColor: Colors.red.shade200,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.background.withOpacity(.5),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: screenSize.height * .2,
          width: screenSize.width * .9,
          child: CustomPaint(
            painter: CurvedRectanglePainter(borderColor: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.red.shade100,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(2, 2),
                                blurRadius: 2,
                                spreadRadius: 0,
                                color: Colors.grey.withOpacity(.7),
                              )
                            ]),
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(notificationModel.imagePath ?? ""),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: screenSize.width * .4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  notificationModel.title ?? '',
                                  style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.lightGreenAccent.shade700.withOpacity(.3),
                                  ),
                                  child: Icon(
                                    Icons.check_circle_outline_outlined,
                                    color: Colors.lightGreenAccent.shade700,
                                    size: 14,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              notificationModel.subtitle ?? '',
                              style: textStyle.bodyMedium!.copyWith(fontWeight: FontWeight.w700, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${notificationModel.dateTime?.hour}.${notificationModel.dateTime?.minute}',
                        style: textStyle.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.lightGreenAccent.shade700,
                        maxRadius: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '1',
                            style: textStyle.bodySmall!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    notificationModel.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
