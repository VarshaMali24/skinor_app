import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/routine_provider.dart';
import '../../models/user_provider.dart';
import '../../utils/theme.dart';
import '../onboarding/profile_setup_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().profile;
    final routine = context.watch<RoutineProvider>();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context, user, routine)),
            SliverToBoxAdapter(child: _buildStats(routine)),
            SliverToBoxAdapter(child: _buildInfoSection(user)),
            SliverToBoxAdapter(child: _buildSkinProfile(user)),
            SliverToBoxAdapter(child: _buildActions(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, UserProfile user, RoutineProvider routine) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFF1DA1F2),
                    Color(0xFFB0C4DE),
                  ],
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
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: SkinorTheme.accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: SkinorTheme.accent.withOpacity(0.4)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.edit, color: SkinorTheme.accent, size: 14),
                      SizedBox(width: 4),
                      Text('Edit',
                          style: TextStyle(
                              color: SkinorTheme.accent,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Avatar
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [SkinorTheme.accent, SkinorTheme.surface],
              ),
              boxShadow: [
                BoxShadow(
                  color: SkinorTheme.accent.withAlpha(210),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                "assets/pngs/main_logo.png",
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            user.name.isNotEmpty ? user.name : 'Skinor User',
            style: const TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '${user.age} years • ${user.skinType.toUpperCase()} SKIN',
            style:
                const TextStyle(color: SkinorTheme.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 12),
          // Streak badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_fire_department,
                    color: Colors.white, size: 18),
                const SizedBox(width: 6),
                Text(
                  '${routine.currentStreak} Day Streak',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(RoutineProvider routine) {
    final stats = [
      {
        'label': 'Morning\nDone',
        'value': routine.morningCompleted ? '✅' : '⏳',
        'color': const Color(0xFFFF8C42)
      },
      {
        'label': 'Evening\nDone',
        'value': routine.eveningCompleted ? '✅' : '⏳',
        'color': const Color(0xFF6A3DE8)
      },
      {
        'label': 'Progress\nToday',
        'value': '${(routine.getTodayProgress() * 100).toInt()}%',
        'color': SkinorTheme.accent
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: stats.map((s) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: SkinorTheme.cardBg,
                borderRadius: BorderRadius.circular(14),
                border:
                    Border.all(color: (s['color'] as Color).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(s['value'] as String,
                      style: TextStyle(
                          color: s['color'] as Color,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(s['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: SkinorTheme.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInfoSection(UserProfile user) {
    final items = [
      {
        'icon': '📍',
        'label': 'Location',
        'value': '${user.state}, ${user.country}'
      },
      {'icon': '🌡️', 'label': 'Climate', 'value': user.climate.toUpperCase()},
      {'icon': '💰', 'label': 'Budget', 'value': user.budget.toUpperCase()},
      {'icon': '🧔', 'label': 'Beard', 'value': user.hasBeard ? 'Yes' : 'No'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Profile Details',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: SkinorTheme.cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: SkinorTheme.divider),
            ),
            child: Column(
              children: items.asMap().entries.map((e) {
                final item = e.value;
                final isLast = e.key == items.length - 1;
                return Column(
                  children: [
                    Row(
                      children: [
                        Text(item['icon']!,
                            style: const TextStyle(fontSize: 20)),
                        const SizedBox(width: 12),
                        Text(item['label']!,
                            style: TextStyle(
                                color: SkinorTheme.textSecondary,
                                fontSize: 13)),
                        const Spacer(),
                        Text(item['value']!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13)),
                      ],
                    ),
                    if (!isLast) ...[
                      const SizedBox(height: 10),
                      Divider(color: SkinorTheme.divider, height: 1),
                      const SizedBox(height: 10),
                    ],
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkinProfile(UserProfile user) {
    if (user.skinConcerns.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Skin Concerns',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: user.skinConcerns.map((c) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: SkinorTheme.accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: SkinorTheme.accent.withOpacity(0.3)),
                ),
                child: Text(c,
                    style: TextStyle(color: SkinorTheme.accent, fontSize: 12)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          if (user != null) ...[],
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Re-setup Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: SkinorTheme.surface,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  UserProfile? get user => null;
}
