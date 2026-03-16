import 'package:flutter/material.dart';
import '../../utils/theme.dart';

// ==================== SALON SCREEN ====================
class SalonScreen extends StatelessWidget {
  const SalonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final treatments = [
      {
        'name': 'Facial Cleanup',
        'frequency': 'Every 30 days',
        'icon': '🧖',
        'cost': '₹400-800',
        'benefit': 'Deep cleanse pores, remove dead cells, brighten skin',
        'lastDone': 'Not done yet',
      },
      {
        'name': 'Hair Trim/Cut',
        'frequency': 'Every 21-30 days',
        'icon': '✂️',
        'cost': '₹150-500',
        'benefit': 'Healthy hair growth, no split ends',
        'lastDone': 'Not done yet',
      },
      {
        'name': 'Beard Grooming',
        'frequency': 'Every 15-20 days',
        'icon': '🪒',
        'cost': '₹100-300',
        'benefit': 'Shape beard, clean neckline, beard treatment',
        'lastDone': 'Not done yet',
      },
      {
        'name': 'Detan Treatment',
        'frequency': 'Every 45 days',
        'icon': '✨',
        'cost': '₹500-1500',
        'benefit': 'Remove tan lines, even skin tone',
        'lastDone': 'Not done yet',
      },
      {
        'name': 'Scalp Treatment',
        'frequency': 'Every 60 days',
        'icon': '💆',
        'cost': '₹600-2000',
        'benefit': 'Reduce dandruff, promote hair growth',
        'lastDone': 'Not done yet',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '✂️ Monthly Salon Routine', const Color(0xFF6A3DE8)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildAlertBanner(
                      '📅 Salon Month Tracker',
                      'Log your salon visits to stay on schedule',
                      SkinorTheme.accentGold,
                    ),
                    const SizedBox(height: 16),
                    ...treatments.map((t) => _buildSalonCard(t)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalonCard(Map<String, String> t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SkinorTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(t['icon']!, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t['name']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: SkinorTheme.accent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(t['frequency']!,
                              style: TextStyle(
                                  color: SkinorTheme.accent, fontSize: 11)),
                        ),
                        const SizedBox(width: 6),
                        Text(t['cost']!,
                            style: TextStyle(
                                color: SkinorTheme.accentGold, fontSize: 11,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(t['benefit']!,
              style:
                  TextStyle(color: SkinorTheme.textSecondary, fontSize: 12)),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today, size: 14),
                  label: const Text('Set Reminder', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: SkinorTheme.accent,
                    side: BorderSide(color: SkinorTheme.accent),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check, size: 14),
                  label: const Text('Done Today', style: TextStyle(fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==================== BEARD SCREEN ====================
class BeardScreen extends StatelessWidget {
  const BeardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'title': 'Wash Beard',
        'freq': 'Daily',
        'icon': '🚿',
        'tip': 'Use a mild beard shampoo or face wash. Avoid regular shampoo — it strips beard oil.',
      },
      {
        'title': 'Beard Oil',
        'freq': 'Daily (evening)',
        'icon': '🫙',
        'tip': '2-3 drops of Argan or Jojoba oil. Massage into beard and skin beneath. Prevents beard dandruff (beardruff).',
      },
      {
        'title': 'Beard Comb',
        'freq': 'Daily',
        'icon': '🔱',
        'tip': 'Use a wooden comb. Comb in growth direction. Detangles and trains beard to grow straight.',
      },
      {
        'title': 'Beard Balm',
        'freq': 'Every 2-3 days',
        'icon': '🏺',
        'tip': 'Apply for styling and extra moisture. Especially useful for longer beards.',
      },
      {
        'title': 'Beard Shaping',
        'freq': 'Every 2-3 days',
        'icon': '✂️',
        'tip': 'Trim neckline 1 inch above Adam\'s apple. Keep cheek line natural. Use a trimmer with guard.',
      },
      {
        'title': 'Deep Condition',
        'freq': 'Weekly',
        'icon': '💆',
        'tip': 'Apply beard butter or coconut oil overnight once a week. Rinse in morning.',
      },
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '🧔 Beard Care Routine', const Color(0xFF00D4AA)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildAlertBanner(
                        '💡 Beard Health = Skin Health',
                        'A well-groomed beard protects skin and boosts confidence!',
                        SkinorTheme.accent),
                    const SizedBox(height: 16),
                    ...steps.asMap().entries.map((e) => _buildBeardCard(e.key + 1, e.value)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeardCard(int num, Map<String, String> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SkinorTheme.divider),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SkinorTheme.accent.withOpacity(0.2),
            ),
            child: Center(
              child: Text('$num',
                  style: TextStyle(color: SkinorTheme.accent, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Text(step['icon']!, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(step['title']!,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: SkinorTheme.accentGold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(step['freq']!,
                          style: TextStyle(
                              color: SkinorTheme.accentGold, fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(step['tip']!,
                    style: TextStyle(color: SkinorTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== WATER TRACKER ====================
class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  int _glasses = 0;
  final int _goal = 8;

  @override
  Widget build(BuildContext context) {
    final percentage = (_glasses / _goal).clamp(0.0, 1.0);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '💧 Water Tracker', const Color(0xFF2196F3)),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Water level visual
                      Container(
                        width: 160,
                        height: 220,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(color: const Color(0xFF2196F3), width: 3),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(77),
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 220 * percentage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        const Color(0xFF2196F3).withOpacity(0.6),
                                        const Color(0xFF0D47A1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$_glasses',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 52,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      '/ $_goal glasses',
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${(_glasses * 250)}ml / ${_goal * 250}ml',
                        style: const TextStyle(
                            color: Color(0xFF2196F3),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _glasses >= _goal
                            ? '🎉 Daily goal complete! Great skin day!'
                            : 'Drink water for hydrated, glowing skin',
                        style: TextStyle(color: SkinorTheme.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _circleBtn(
                            Icons.remove,
                            () => setState(() {
                              if (_glasses > 0) _glasses--;
                            }),
                            Colors.red,
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            onPressed: () => setState(() {
                              if (_glasses < _goal + 4) _glasses++;
                            }),
                            icon: const Text('💧', style: TextStyle(fontSize: 18)),
                            label: const Text('Add Glass'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 14),
                            ),
                          ),
                          const SizedBox(width: 20),
                          _circleBtn(
                            Icons.refresh,
                            () => setState(() => _glasses = 0),
                            SkinorTheme.textSecondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildWaterTips(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback onPressed, Color color) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildWaterTips() {
    final tips = [
      '🌅 Drink 2 glasses immediately after waking up',
      '☀️ Drink before meals, not during',
      '🌙 2 glasses 1 hour before bed',
      '🏃 Extra 1-2 glasses after workout',
      '✨ Water flushes toxins = clear skin',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('💡 Skin Hydration Tips',
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...tips.map((t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(t,
                        style: TextStyle(
                            color: SkinorTheme.textSecondary, fontSize: 13)),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

// ==================== SLEEP SCREEN ====================
class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routine = [
      {'time': '9:30 PM', 'action': 'Apply night cream', 'icon': '🌙', 'done': false},
      {'time': '9:45 PM', 'action': 'Drink 2 glasses water', 'icon': '💧', 'done': false},
      {'time': '10:00 PM', 'action': 'No screen time', 'icon': '📵', 'done': false},
      {'time': '10:00 PM', 'action': 'Light reading or meditation', 'icon': '📖', 'done': false},
      {'time': '10:30 PM', 'action': 'Sleep on back, silk pillowcase', 'icon': '😴', 'done': false},
      {'time': '6:30 AM', 'action': 'Wake up (7-8 hrs rest)', 'icon': '⏰', 'done': false},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '😴 Sleep Routine', const Color(0xFF3F51B5)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildAlertBanner(
                        '🌙 Beauty Sleep is Real',
                        'Skin repairs itself between 10 PM – 2 AM. Don\'t miss this golden window!',
                        const Color(0xFF3F51B5)),
                    const SizedBox(height: 16),
                    ...routine.map((r) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: SkinorTheme.cardBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: SkinorTheme.divider),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3F51B5).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(r['time'] as String,
                                    style: const TextStyle(
                                        color: Color(0xFF3F51B5),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(width: 12),
                              Text(r['icon'] as String,
                                  style: const TextStyle(fontSize: 22)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(r['action'] as String,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                    _buildSleepTips(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSleepTips() {
    final tips = [
      '🛏️ Use silk/satin pillowcase — reduces skin friction & breakouts',
      '❄️ Keep room cool (18-20°C) for better sleep quality',
      '🚫 No phone in bedroom — blue light disrupts melatonin',
      '🧴 Always apply night cream before bed',
      '💊 Consider Melatonin supplement if sleep is poor (consult doctor)',
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF3F51B5).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡 Sleep & Skin Tips',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ...tips.map((t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(t,
                    style: TextStyle(
                        color: SkinorTheme.textSecondary, fontSize: 12, height: 1.4)),
              )),
        ],
      ),
    );
  }
}

// ==================== WORKOUT SCREEN ====================
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {'name': 'Jump Rope', 'sets': '5 min', 'icon': '🪢', 'benefit': 'Boosts circulation, glowing skin'},
      {'name': 'Push-ups', 'sets': '3x15', 'icon': '💪', 'benefit': 'Upper body strength, posture'},
      {'name': 'Squats', 'sets': '3x20', 'icon': '🦵', 'benefit': 'Full body circulation boost'},
      {'name': 'Face Yoga', 'sets': '5 min', 'icon': '😄', 'benefit': 'Tone face muscles, reduce puffiness'},
      {'name': 'Neck Rolls', 'sets': '2 min', 'icon': '🔄', 'benefit': 'Reduce neck tension, better posture'},
      {'name': 'Cold Shower', 'sets': '30-60 sec', 'icon': '🚿', 'benefit': 'Closes pores, energizes skin'},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '💪 Morning Workout', const Color(0xFFFF5722)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildAlertBanner(
                        '🏃 Workout = Better Skin',
                        'Exercise increases blood flow to skin, delivers nutrients & flushes toxins!',
                        const Color(0xFFFF5722)),
                    const SizedBox(height: 16),
                    ...exercises.map((e) => Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: SkinorTheme.cardBg,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: SkinorTheme.divider),
                          ),
                          child: Row(
                            children: [
                              Text(e['icon']!,
                                  style: const TextStyle(fontSize: 28)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(e['name']!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFF5722)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(e['sets']!,
                                              style: const TextStyle(
                                                  color: Color(0xFFFF5722),
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ],
                                    ),
                                    Text(e['benefit']!,
                                        style: TextStyle(
                                            color: SkinorTheme.textSecondary,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: SkinorTheme.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFFFF5722).withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('⚠️ Post-Workout Skin Care',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                          const SizedBox(height: 8),
                          Text(
                            '• Wash face within 30 min of workout\n'
                            '• Don\'t touch face with sweaty hands\n'
                            '• Reapply sunscreen if going outdoors\n'
                            '• Drink water immediately after',
                            style: TextStyle(
                                color: SkinorTheme.textSecondary, fontSize: 12, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== ADDICTION/HABIT SCREEN ====================
class AddictionScreen extends StatelessWidget {
  const AddictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, '🚬 Habit & Health Care', const Color(0xFF795548)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildHabitSection(
                      '🚬 Smoking & Skin',
                      const Color(0xFF795548),
                      [
                        'Smoking reduces collagen = premature wrinkles',
                        'Causes uneven skin tone & dullness',
                        'Reduces blood flow to face',
                        'Causes lip darkening & dark circles',
                        'Every cigarette = accelerated skin aging',
                      ],
                      '💊 Maintenance Tips',
                      [
                        'Use Vitamin C serum daily to fight oxidative damage',
                        'Use retinol at night (consult dermatologist)',
                        'Stay extra hydrated — smoke dehydrates skin',
                        'Use SPF50+ every day without fail',
                        'Take Zinc & Omega-3 supplements',
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildHabitSection(
                      '🍺 Alcohol & Skin',
                      const Color(0xFFFF7043),
                      [
                        'Alcohol dehydrates skin severely',
                        'Causes facial redness & broken capillaries',
                        'Depletes Vitamin A & Zinc (crucial for skin)',
                        'Disrupts sleep = poor skin recovery',
                        'Causes puffiness and bloating',
                      ],
                      '💧 Recovery Tips',
                      [
                        'Drink 2 extra glasses of water per drink consumed',
                        'Apply extra hydrating mask next morning',
                        'Take B-complex vitamins daily',
                        'Never sleep without washing face after drinking',
                        'Limit to max 2 drinks, avoid more than 2x/week',
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHabitSection(String title, Color color, List<String> effects,
      String tipsTitle, List<String> tips) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('⚡ Skin Effects:',
              style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 13)),
          const SizedBox(height: 6),
          ...effects.map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: color, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(e,
                            style: TextStyle(
                                color: SkinorTheme.textSecondary, fontSize: 12))),
                  ],
                ),
              )),
          const SizedBox(height: 14),
          Text(tipsTitle,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 6),
          ...tips.map((t) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: color, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                        child: Text(t,
                            style: TextStyle(
                                color: SkinorTheme.textSecondary, fontSize: 12))),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ==================== SHARED WIDGETS ====================
Widget _buildAppBar(BuildContext context, String title, Color accentColor) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      border: Border(
          bottom: BorderSide(color: SkinorTheme.divider, width: 1)),
    ),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

Widget _buildAlertBanner(String title, String subtitle, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: TextStyle(color: SkinorTheme.textSecondary, fontSize: 12)),
      ],
    ),
  );
}
