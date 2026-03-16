import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/routine_provider.dart';
import '../../models/user_provider.dart';
import '../../utils/theme.dart';
import '../features/alerts_screen.dart';
import '../features/salon_screen.dart';
import '../profile/profile_screen.dart';
import '../routine/morning_routine_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().profile;
    final routine = context.watch<RoutineProvider>();

    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _HomeTab(user: user, routine: routine),
          const AlertsScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: SkinorTheme.secondary,
          border: Border(
            top: BorderSide(color: SkinorTheme.divider, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (i) => setState(() => _selectedTab = i),
          backgroundColor: Colors.transparent,
          selectedItemColor: SkinorTheme.accent,
          unselectedItemColor: SkinorTheme.textSecondary,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_rounded),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  final UserProfile user;
  final RoutineProvider routine;

  const _HomeTab({required this.user, required this.routine});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildProgressCard()),
            SliverToBoxAdapter(child: _buildSectionTitle('Daily Routines')),
            SliverToBoxAdapter(child: _buildRoutineCards(context)),
            SliverToBoxAdapter(child: _buildSectionTitle('Lifestyle & Care')),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: _buildFeatureGrid(context),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting() + ',',
                  style:
                      TextStyle(color: SkinorTheme.textSecondary, fontSize: 14),
                ),
                Text(
                  user.name.isNotEmpty ? user.name : 'Handsome!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.local_fire_department,
                        color: SkinorTheme.accentGold, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${routine.currentStreak} day streak',
                      style: TextStyle(
                          color: SkinorTheme.accentGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [SkinorTheme.accent, SkinorTheme.surface],
                ),
                boxShadow: [
                  BoxShadow(
                    color: SkinorTheme.accent.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Center(
                child: Text('🧔', style: TextStyle(fontSize: 26)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    final progress = routine.getTodayProgress();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            SkinorTheme.accent.withOpacity(0.2),
            SkinorTheme.surface.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SkinorTheme.accent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Progress",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                    color: SkinorTheme.accent,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: SkinorTheme.divider,
              valueColor: AlwaysStoppedAnimation<Color>(SkinorTheme.accent),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _sessionBadge('🌅 Morning', routine.morningCompleted),
              const SizedBox(width: 8),
              _sessionBadge('🌆 Evening', routine.eveningCompleted),
              const SizedBox(width: 8),
              _sessionBadge('🌙 Night', routine.nightCompleted),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sessionBadge(String label, bool done) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color:
              done ? SkinorTheme.success.withOpacity(0.2) : SkinorTheme.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: done ? SkinorTheme.success : SkinorTheme.divider,
          ),
        ),
        child: Column(
          children: [
            Icon(done ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 14,
                color: done ? SkinorTheme.success : SkinorTheme.textSecondary),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                  color: done ? SkinorTheme.success : SkinorTheme.textSecondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRoutineCards(BuildContext context) {
    final sessions = [
      {
        'title': 'Morning Routine',
        'subtitle': '5 Steps • 7 min',
        'icon': '🌅',
        'gradient': [const Color(0xFFFF8C42), const Color(0xFFFFB347)],
        'done': routine.morningCompleted,
        'screen': const MorningRoutineScreen(),
      },
      {
        'title': 'Evening Routine',
        'subtitle': '4 Steps • 10 min',
        'icon': '🌆',
        'gradient': [const Color(0xFF6A3DE8), const Color(0xFF0F3460)],
        'done': routine.eveningCompleted,
        'screen': const EveningRoutineScreen(),
      },
      {
        'title': 'Night Routine',
        'subtitle': '3 Steps • 5 min',
        'icon': '🌙',
        'gradient': [const Color(0xFF1A1A4E), const Color(0xFF0A0E1A)],
        'done': routine.nightCompleted,
        'screen': const NightRoutineScreen(),
      },
    ];

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: sessions.length,
        itemBuilder: (ctx, i) {
          final s = sessions[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => s['screen'] as Widget),
            ),
            child: Container(
              width: 160,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: s['gradient'] as List<Color>,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (s['done'] as bool)
                      ? SkinorTheme.success.withOpacity(0.5)
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(s['icon'] as String,
                          style: const TextStyle(fontSize: 28)),
                      if (s['done'] as bool)
                        Icon(Icons.check_circle,
                            color: SkinorTheme.success, size: 18),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        s['subtitle'] as String,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    final features = [
      {
        'icon': '✂️',
        'label': 'Salon\nRoutine',
        'screen': const SalonScreen(),
        'color': const Color(0xFF6A3DE8)
      },
      {
        'icon': '🧔',
        'label': 'Beard\nCare',
        'screen': const BeardScreen(),
        'color': const Color(0xFF00D4AA)
      },
      {
        'icon': '💧',
        'label': 'Water\nTracker',
        'screen': const WaterTrackerScreen(),
        'color': const Color(0xFF2196F3)
      },
      {
        'icon': '😴',
        'label': 'Sleep\nRoutine',
        'screen': const SleepScreen(),
        'color': const Color(0xFF3F51B5)
      },
      {
        'icon': '💪',
        'label': 'Morning\nWorkout',
        'screen': const WorkoutScreen(),
        'color': const Color(0xFFFF5722)
      },
      {
        'icon': '🚬',
        'label': 'Habit\nHealth',
        'screen': const AddictionScreen(),
        'color': const Color(0xFF795548)
      },
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (ctx, i) {
          final f = features[i];
          return GestureDetector(
            onTap: () => Navigator.push(
              ctx,
              MaterialPageRoute(builder: (_) => f['screen'] as Widget),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: (f['color'] as Color).withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: (f['color'] as Color).withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(f['icon'] as String,
                      style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 6),
                  Text(
                    f['label'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: SkinorTheme.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: features.length,
      ),
    );
  }
}
