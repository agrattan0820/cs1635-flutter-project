import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:grosseries/components/utilities.dart';
import 'package:grosseries/models/food_item.dart';
import 'package:grosseries/models/list_food_entry.dart';

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

Future<void> createTestFoodExpireNotification(
    ListFoodEntry listFoodEntry, FoodItem foodItem) async {
  String emoji = foodItem.category == 0
      ? Emojis.food_red_apple
      : foodItem.category == 1
          ? Emojis.food_glass_of_milk
          : foodItem.category == 2
              ? Emojis.food_meat_on_bone
              : foodItem.category == 3
                  ? Emojis.food_bread
                  : foodItem.category == 4
                      ? Emojis.animals_fish
                      : foodItem.category == 5
                          ? Emojis.food_candy
                          : Emojis.household_shopping_cart;

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: "basic_channel",
      title:
          "$emoji Your ${foodItem.name}${listFoodEntry.quantity > 1 ? 's' : ''} are about to go bad!",
      body:
          "Double check the quality of your ${foodItem.name}${listFoodEntry.quantity > 1 ? 's' : ''}",
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> createFoodExpireReminderNotification(ListFoodEntry listFoodEntry,
    FoodItem foodItem, NotificationDay notificationSchedule) async {
  String localTimeZone =
      await AwesomeNotifications().getLocalTimeZoneIdentifier();
  debugPrint(localTimeZone);

  String emoji = foodItem.category == 0
      ? Emojis.food_red_apple
      : foodItem.category == 1
          ? Emojis.food_glass_of_milk
          : foodItem.category == 2
              ? Emojis.food_meat_on_bone
              : foodItem.category == 3
                  ? Emojis.food_bread
                  : foodItem.category == 4
                      ? Emojis.animals_fish
                      : foodItem.category == 5
                          ? Emojis.food_candy
                          : Emojis.household_shopping_cart;

  var notification = await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title:
          "$emoji Your ${foodItem.name}${listFoodEntry.quantity > 1 ? 's' : ''} are about to go bad!",
      body:
          "Double check the quality of your ${foodItem.name}${listFoodEntry.quantity > 1 ? 's' : ''}",
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
