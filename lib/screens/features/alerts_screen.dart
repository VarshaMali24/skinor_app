import 'package:flutter/material.dart';
import '../../utils/theme.dart';
import '../../services/notification_service.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  final Map<String, bool> _alerts = {
    'morning_routine': true,
    'face_wash_noon': true,
    'evening_routine': true,
    'water_reminder': true,
    'sleep_reminder': true,
    'workout_reminder': false,
    'salon_monthly': true,
    'beard_routine': false,
  };

  final List<Map<String, dynamic>> _alertItems = [
    {
      'id': 'morning_routine',
      'title': '🌅 Morning Routine',
      'time': '6:30 AM',
      'desc': 'Start your skincare day',
      'color': Color(0xFFFF8C42),
    },
    {
      'id': 'face_wash_noon',
      'title': '🧼 Midday Face Wash',
      'time': '12:30 PM',
      'desc': 'Remove oil & refresh',
      'color': Color(0xFF2196F3),
    },
    {
      'id': 'water_reminder',
      'title': '💧 Hydration Alerts',
      'time': 'Every 2 hrs',
      'desc': 'Drink water reminder',
      'color': Color(0xFF00BCD4),
    },
    {
      'id': 'evening_routine',
      'title': '🌆 Evening Routine',
      'time': '7:00 PM',
      'desc': 'Cleanse & treat skin',
      'color': Color(0xFF6A3DE8),
    },
    {
      'id': 'sleep_reminder',
      'title': '😴 Sleep Reminder',
      'time': '10:00 PM',
      'desc': 'Time for beauty sleep',
      'color': Color(0xFF3F51B5),
    },
    {
      'id': 'workout_reminder',
      'title': '💪 Morning Workout',
      'time': '6:00 AM',
      'desc': 'Exercise for glowing skin',
      'color': Color(0xFFFF5722),
    },
    {
      'id': 'beard_routine',
      'title': '🧔 Beard Care',
      'time': '8:00 PM',
      'desc': 'Apply beard oil & comb',
      'color': Color(0xFF00D4AA),
    },
    {
      'id': 'salon_monthly',
      'title': '✂️ Monthly Salon',
      'time': 'Monthly',
      'desc': 'Facial, haircut & grooming',
      'color': Color(0xFFE91E63),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF00D4AA), Color(0xFFFFB347)],
                    ).createShader(bounds),
                    child: const Text(
                      'SKINOR',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_active,
                      color: Color(0xFFFFB347), size: 24),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Smart Alerts',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reminders to keep your routine consistent',
                  style: TextStyle(
                      color: SkinorTheme.textSecondary, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _alertItems.length,
                itemBuilder: (_, i) {
                  final item = _alertItems[i];
                  final id = item['id'] as String;
                  final enabled = _alerts[id] ?? false;
                  final color = item['color'] as Color;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: enabled
                          ? color.withOpacity(0.08)
                          : SkinorTheme.cardBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: enabled
                            ? color.withOpacity(0.3)
                            : SkinorTheme.divider,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.withOpacity(0.15),
                          ),
                          child: Center(
                            child: Text(
                              item['title'].toString().split(' ')[0],
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'].toString().substring(
                                    item['title'].toString().indexOf(' ') + 1),
                                style: TextStyle(
                                  color: enabled ? Colors.white : SkinorTheme.textSecondary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      size: 11, color: color),
                                  const SizedBox(width: 3),
                                  Text(
                                    item['time'] as String,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• ${item['desc']}',
                                    style: TextStyle(
                                        color: SkinorTheme.textSecondary,
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: enabled,
                          onChanged: (v) {
                            setState(() => _alerts[id] = v);
                            if (v) {
                              _triggerNotification(id);
                            }
                          },
                          activeColor: color,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _triggerNotification(String id) {
    switch (id) {
      case 'morning_routine':
        NotificationService.scheduleMorningRoutine();
        break;
      case 'face_wash_noon':
        NotificationService.scheduleFaceWashAlert();
        break;
      case 'evening_routine':
        NotificationService.scheduleEveningRoutine();
        break;
      case 'water_reminder':
        NotificationService.scheduleWaterAlert();
        break;
      case 'sleep_reminder':
        NotificationService.scheduleSleepReminder();
        break;
      case 'workout_reminder':
        NotificationService.scheduleWorkoutReminder();
        break;
      case 'salon_monthly':
        NotificationService.scheduleSalonReminder();
        break;
    }
  }
}
