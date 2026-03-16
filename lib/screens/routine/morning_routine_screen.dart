import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/routine_provider.dart';
import '../../utils/theme.dart';
import '../../widgets/routine_step_card.dart';

class MorningRoutineScreen extends StatelessWidget {
  const MorningRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _RoutineScreen(
      title: 'Morning Routine',
      icon: '🌅',
      subtitle: 'Start your day with great skin',
      sessionType: 'morning',
      gradientColors: const [Color(0xFFFF8C42), Color(0xFFFF4500)],
    );
  }
}

class EveningRoutineScreen extends StatelessWidget {
  const EveningRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _RoutineScreen(
      title: 'Evening Routine',
      icon: '🌆',
      subtitle: 'Repair and prep for nighttime',
      sessionType: 'evening',
      gradientColors: const [Color(0xFF6A3DE8), Color(0xFF0F3460)],
    );
  }
}

class NightRoutineScreen extends StatelessWidget {
  const NightRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _RoutineScreen(
      title: 'Night Routine',
      icon: '🌙',
      subtitle: 'End the day, let your skin recover',
      sessionType: 'night',
      gradientColors: const [Color(0xFF1A1A4E), Color(0xFF0A0E1A)],
    );
  }
}

class _RoutineScreen extends StatelessWidget {
  final String title;
  final String icon;
  final String subtitle;
  final String sessionType;
  final List<Color> gradientColors;

  const _RoutineScreen({
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.sessionType,
    required this.gradientColors,
  });

  List<RoutineStep> _getSteps(RoutineProvider provider) {
    switch (sessionType) {
      case 'morning':
        return provider.morningRoutine;
      case 'evening':
        return provider.eveningRoutine;
      default:
        return provider.nightRoutine;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoutineProvider>(builder: (ctx, routine, _) {
      final steps = _getSteps(routine);
      final completed = steps.where((s) => s.isCompleted).length;

      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A0E1A), Color(0xFF1A1A2E)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(icon, style: const TextStyle(fontSize: 28)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        subtitle,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 13),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: steps.isEmpty ? 0 : completed / steps.length,
                                backgroundColor: Colors.white.withOpacity(0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                minHeight: 6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '$completed/${steps.length}',
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Steps
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: steps.length,
                    itemBuilder: (_, i) => RoutineStepCard(
                      step: steps[i],
                      stepNumber: i + 1,
                      onToggle: () =>
                          routine.toggleStep(sessionType, steps[i].id),
                    ),
                  ),
                ),
                // All done button
                if (completed == steps.length && steps.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: SkinorTheme.success.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: SkinorTheme.success),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: SkinorTheme.success),
                          const SizedBox(width: 8),
                          Text(
                            '$title Complete! 🎉',
                            style: TextStyle(
                              color: SkinorTheme.success,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
