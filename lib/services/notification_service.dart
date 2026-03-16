import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _notifications.initialize(settings);
  }

  static Future<void> scheduleMorningRoutine() async {
    const androidDetails = AndroidNotificationDetails(
      'morning_routine',
      'Morning Routine',
      channelDescription: 'Morning skincare routine reminder',
      importance: Importance.high,
      priority: Priority.high,
      color: Color(0xFF00D4AA),
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      1,
      '🌅 Morning Routine Time!',
      'Start your day with great skin! Your 5-step routine awaits.',
      details,
    );
  }

  static Future<void> scheduleEveningRoutine() async {
    const androidDetails = AndroidNotificationDetails(
      'evening_routine',
      'Evening Routine',
      channelDescription: 'Evening skincare routine reminder',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      2,
      '🌆 Evening Routine Time!',
      'Cleanse the day away. Your skin needs you!',
      details,
    );
  }

  static Future<void> scheduleWaterAlert() async {
    const androidDetails = AndroidNotificationDetails(
      'water_reminder',
      'Water Reminder',
      channelDescription: 'Drink water reminder for skin health',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      3,
      '💧 Time to Hydrate!',
      'Drink water now — glowing skin starts from within!',
      details,
    );
  }

  static Future<void> scheduleFaceWashAlert() async {
    const androidDetails = AndroidNotificationDetails(
      'face_wash',
      'Face Wash',
      channelDescription: 'Face wash reminder',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      4,
      '🧼 Wash Your Face!',
      'Remove oil, sweat & pollution. Keep your skin clean!',
      details,
    );
  }

  static Future<void> scheduleSleepReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'sleep_reminder',
      'Sleep Reminder',
      channelDescription: 'Sleep reminder for skin recovery',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      5,
      '😴 Time to Sleep!',
      'Your skin repairs itself while you sleep. Rest up!',
      details,
    );
  }

  static Future<void> scheduleWorkoutReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'workout_reminder',
      'Workout Reminder',
      channelDescription: 'Morning workout reminder',
      importance: Importance.high,
      priority: Priority.high,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      6,
      '💪 Morning Workout!',
      'Exercise boosts blood flow = glowing skin. Let\'s go!',
      details,
    );
  }

  static Future<void> scheduleSalonReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'salon_reminder',
      'Monthly Salon',
      channelDescription: 'Monthly salon routine reminder',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      7,
      '✂️ Salon Day This Week!',
      'Time for your monthly facial, haircut & beard grooming!',
      details,
    );
  }

  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }
}
