class NotificationModel {
  final String? notificationId;
  final String? title;
  final String? subtitle;
  final String? description;
  final DateTime? dateTime;
  final String? imagePath;

  NotificationModel({this.title, this.subtitle, this.description, this.dateTime, this.imagePath, this.notificationId});

  NotificationModel copyWith(String? title, String? subtitle, String? description, DateTime? dateTime,
          String? imagePath, String? notificationId) =>
      NotificationModel(
          dateTime: dateTime ?? this.dateTime,
          title: title ?? this.title,
          subtitle: subtitle ?? this.subtitle,
          description: description ?? this.description,
          imagePath: imagePath ?? this.imagePath,
          notificationId: notificationId ?? this.notificationId);
}
