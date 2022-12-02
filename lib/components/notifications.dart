import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:grosseries/components/utilities.dart';

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }
}

Future<void> createFoodExpireNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: "basic_channel",
      title: 'Your whole milk is about to go bad!',
      body: 'Your whole milk has one day left until it goes bad',
    ),
  );
}

Future<void> createFoodExpireReminderNotification(
    NotificationDay notificationSchedule) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  debugPrint(localTimeZone);
  var notification = await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: "Hello",
      body: 'Water your plant regularly to keep it healthy.',
      notificationLayout: NotificationLayout.Default,
    ),
    schedule: NotificationCalendar(
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      day: notificationSchedule.day,
      month: notificationSchedule.month,
      year: notificationSchedule.year,
      timeZone: localTimeZone,
      second: 0,
      millisecond: 0,
    ),
  );
  debugPrint("Notification happened: $notification");
  List list = await AwesomeNotifications().listScheduledNotifications();

  debugPrint(list.toString());
}
