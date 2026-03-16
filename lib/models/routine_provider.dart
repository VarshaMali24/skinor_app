import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutineStep {
  final String id;
  final String title;
  final String description;
  final String howToUse;
  final String productType;
  final String duration; // e.g., "2 minutes"
  final String icon;
  bool isCompleted;

  RoutineStep({
    required this.id,
    required this.title,
    required this.description,
    required this.howToUse,
    required this.productType,
    required this.duration,
    required this.icon,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'howToUse': howToUse,
        'productType': productType,
        'duration': duration,
        'icon': icon,
        'isCompleted': isCompleted,
      };

  factory RoutineStep.fromJson(Map<String, dynamic> json) => RoutineStep(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        howToUse: json['howToUse'],
        productType: json['productType'],
        duration: json['duration'],
        icon: json['icon'],
        isCompleted: json['isCompleted'] ?? false,
      );
}

class DailyProgress {
  final String date;
  int completedSteps;
  int totalSteps;

  DailyProgress({
    required this.date,
    required this.completedSteps,
    required this.totalSteps,
  });

  double get percentage => totalSteps > 0 ? completedSteps / totalSteps : 0.0;
}

class RoutineProvider extends ChangeNotifier {
  List<RoutineStep> _morningRoutine = [];
  List<RoutineStep> _eveningRoutine = [];
  List<RoutineStep> _nightRoutine = [];
  List<DailyProgress> _weekProgress = [];
  int _currentStreak = 0;
  bool _morningCompleted = false;
  bool _eveningCompleted = false;
  bool _nightCompleted = false;

  List<RoutineStep> get morningRoutine => _morningRoutine;
  List<RoutineStep> get eveningRoutine => _eveningRoutine;
  List<RoutineStep> get nightRoutine => _nightRoutine;
  List<DailyProgress> get weekProgress => _weekProgress;
  int get currentStreak => _currentStreak;
  bool get morningCompleted => _morningCompleted;
  bool get eveningCompleted => _eveningCompleted;
  bool get nightCompleted => _nightCompleted;

  RoutineProvider() {
    _loadRoutines();
    _generateDefaultRoutines();
    _loadStreak();
  }

  void _generateDefaultRoutines() {
    if (_morningRoutine.isEmpty) {
      _morningRoutine = [
        RoutineStep(
          id: 'm1',
          title: 'Face Wash',
          description: 'Cleanse your face to remove overnight oil & dirt',
          howToUse:
              '1. Wet face with lukewarm water\n2. Apply pea-sized amount\n3. Gently massage in circular motions for 60 seconds\n4. Rinse thoroughly\n5. Pat dry with clean towel',
          productType: 'Cleanser',
          duration: '2 min',
          icon: '🧼',
        ),
        RoutineStep(
          id: 'm2',
          title: 'Toner',
          description: 'Balance skin pH and prep for moisturizer',
          howToUse:
              '1. Pour few drops on cotton pad\n2. Swipe gently across face\n3. Or pat directly with hands\n4. Allow to absorb for 30 seconds',
          productType: 'Toner',
          duration: '1 min',
          icon: '💧',
        ),
        RoutineStep(
          id: 'm3',
          title: 'Moisturizer',
          description: 'Hydrate and protect skin barrier',
          howToUse:
              '1. Take pea-sized amount\n2. Warm between fingertips\n3. Apply from center outward\n4. Don\'t forget neck',
          productType: 'Moisturizer',
          duration: '1 min',
          icon: '🫧',
        ),
        RoutineStep(
          id: 'm4',
          title: 'Sunscreen SPF 50+',
          description: 'MUST. Protect from UV damage & dark spots',
          howToUse:
              '1. Apply generously 15 min before sun exposure\n2. Use 2 finger rule for face\n3. Reapply every 2-3 hours outdoors',
          productType: 'Sunscreen',
          duration: '1 min',
          icon: '☀️',
        ),
        RoutineStep(
          id: 'm5',
          title: 'Lip Balm',
          description: 'Keep lips moisturized and protected',
          howToUse:
              '1. Apply a thin layer\n2. Reapply throughout the day\n3. Choose SPF lip balm for day use',
          productType: 'Lip Care',
          duration: '30 sec',
          icon: '💋',
        ),
      ];
    }

    if (_eveningRoutine.isEmpty) {
      _eveningRoutine = [
        RoutineStep(
          id: 'e1',
          title: 'Face Wash',
          description: 'Remove sunscreen, sweat, pollution of the day',
          howToUse:
              '1. Use lukewarm water\n2. Double cleanse if heavy sunscreen\n3. Massage gently 60 seconds\n4. Rinse well',
          productType: 'Cleanser',
          duration: '2 min',
          icon: '🧼',
        ),
        RoutineStep(
          id: 'e2',
          title: 'Serum / Treatment',
          description: 'Target specific skin concerns (acne, dark spots)',
          howToUse:
              '1. Apply 2-3 drops on clean skin\n2. Press gently into skin\n3. Wait 5 minutes before next step\n4. Niacinamide for oily skin, Vitamin C for dull skin',
          productType: 'Serum',
          duration: '5 min',
          icon: '⚗️',
        ),
        RoutineStep(
          id: 'e3',
          title: 'Night Moisturizer',
          description: 'Repair and hydrate overnight',
          howToUse:
              '1. Apply thicker cream at night\n2. Massage upward strokes\n3. Include eye area gently',
          productType: 'Moisturizer',
          duration: '1 min',
          icon: '🌙',
        ),
        RoutineStep(
          id: 'e4',
          title: 'Beard Care',
          description: 'Condition and maintain beard',
          howToUse:
              '1. Apply beard oil 2-3 drops\n2. Massage into beard and skin beneath\n3. Comb through\n4. Apply beard balm for styling',
          productType: 'Beard Oil',
          duration: '2 min',
          icon: '🧔',
        ),
      ];
    }

    if (_nightRoutine.isEmpty) {
      _nightRoutine = [
        RoutineStep(
          id: 'n1',
          title: 'Drink Water',
          description: '2 glasses of water before bed for skin hydration',
          howToUse:
              '1. Drink 400-500ml water\n2. Avoid drinking too close to bed\n3. Keep water bottle on nightstand',
          productType: 'Hydration',
          duration: '2 min',
          icon: '💦',
        ),
        RoutineStep(
          id: 'n2',
          title: 'Sleep Posture',
          description: 'Sleep on your back to avoid sleep creases',
          howToUse:
              '1. Use silk or satin pillowcase\n2. Sleep on back when possible\n3. Elevate head slightly\n4. 7-8 hours minimum',
          productType: 'Sleep Care',
          duration: '8 hours',
          icon: '😴',
        ),
        RoutineStep(
          id: 'n3',
          title: 'Screen Off Time',
          description: 'No phone 30 min before bed for better skin & sleep',
          howToUse:
              '1. Set do-not-disturb at 10 PM\n2. Use night mode after sunset\n3. Try reading instead\n4. Blue light causes skin stress',
          productType: 'Lifestyle',
          duration: '30 min',
          icon: '📵',
        ),
      ];
    }
  }

  Future<void> _loadRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    // Load completion status for today
    final today = DateTime.now().toIso8601String().substring(0, 10);
    _morningCompleted = prefs.getBool('morning_$today') ?? false;
    _eveningCompleted = prefs.getBool('evening_$today') ?? false;
    _nightCompleted = prefs.getBool('night_$today') ?? false;
    notifyListeners();
  }

  Future<void> _loadStreak() async {
    final prefs = await SharedPreferences.getInstance();
    _currentStreak = prefs.getInt('streak') ?? 0;
    notifyListeners();
  }

  void toggleStep(String sessionType, String stepId) {
    List<RoutineStep> routine;
    if (sessionType == 'morning') {
      routine = _morningRoutine;
    } else if (sessionType == 'evening') {
      routine = _eveningRoutine;
    } else {
      routine = _nightRoutine;
    }

    final step = routine.firstWhere((s) => s.id == stepId);
    step.isCompleted = !step.isCompleted;
    notifyListeners();
    _checkSessionCompletion(sessionType, routine);
  }

  Future<void> _checkSessionCompletion(
      String session, List<RoutineStep> routine) async {
    final allDone = routine.every((s) => s.isCompleted);
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (session == 'morning') {
      _morningCompleted = allDone;
      await prefs.setBool('morning_$today', allDone);
    } else if (session == 'evening') {
      _eveningCompleted = allDone;
      await prefs.setBool('evening_$today', allDone);
    } else {
      _nightCompleted = allDone;
      await prefs.setBool('night_$today', allDone);
    }

    if (_morningCompleted && _eveningCompleted) {
      _currentStreak++;
      await prefs.setInt('streak', _currentStreak);
    }
    notifyListeners();
  }

  double getTodayProgress() {
    final allSteps = [..._morningRoutine, ..._eveningRoutine, ..._nightRoutine];
    if (allSteps.isEmpty) return 0;
    final completed = allSteps.where((s) => s.isCompleted).length;
    return completed / allSteps.length;
  }
}
