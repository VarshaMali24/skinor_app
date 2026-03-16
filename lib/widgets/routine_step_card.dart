import 'package:flutter/material.dart';
import '../models/routine_provider.dart';
import '../utils/theme.dart';

class RoutineStepCard extends StatefulWidget {
  final RoutineStep step;
  final int stepNumber;
  final VoidCallback onToggle;

  const RoutineStepCard({
    super.key,
    required this.step,
    required this.stepNumber,
    required this.onToggle,
  });

  @override
  State<RoutineStepCard> createState() => _RoutineStepCardState();
}

class _RoutineStepCardState extends State<RoutineStepCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: widget.step.isCompleted
            ? SkinorTheme.success.withOpacity(0.08)
            : SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.step.isCompleted
              ? SkinorTheme.success.withOpacity(0.4)
              : SkinorTheme.divider,
          width: widget.step.isCompleted ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Step number / check
                  GestureDetector(
                    onTap: widget.onToggle,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.step.isCompleted
                            ? SkinorTheme.success
                            : SkinorTheme.divider,
                      ),
                      child: Center(
                        child: widget.step.isCompleted
                            ? const Icon(Icons.check, color: Colors.white, size: 20)
                            : Text(
                                '${widget.stepNumber}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Icon
                  Text(widget.step.icon, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.step.title,
                          style: TextStyle(
                            color: widget.step.isCompleted
                                ? SkinorTheme.textSecondary
                                : Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            decoration: widget.step.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        Text(
                          widget.step.description,
                          style: TextStyle(
                              color: SkinorTheme.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Duration & expand
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: SkinorTheme.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.step.duration,
                          style: TextStyle(
                              color: SkinorTheme.accent,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        _expanded ? Icons.expand_less : Icons.expand_more,
                        color: SkinorTheme.textSecondary,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // How to use section
          if (_expanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: SkinorTheme.primary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: SkinorTheme.accent.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: SkinorTheme.accent, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'HOW TO USE',
                          style: TextStyle(
                            color: SkinorTheme.accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.step.howToUse,
                      style: TextStyle(
                          color: SkinorTheme.textSecondary,
                          fontSize: 13,
                          height: 1.6),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _infoChip('Type', widget.step.productType),
                        const SizedBox(width: 8),
                        _infoChip('Time', widget.step.duration),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: widget.onToggle,
                        icon: Icon(
                          widget.step.isCompleted ? Icons.refresh : Icons.check,
                          size: 16,
                        ),
                        label: Text(
                          widget.step.isCompleted
                              ? 'Mark Incomplete'
                              : 'Mark Done',
                          style: const TextStyle(fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.step.isCompleted
                              ? SkinorTheme.divider
                              : SkinorTheme.success,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: SkinorTheme.cardBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: SkinorTheme.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: SkinorTheme.textSecondary, fontSize: 11),
          ),
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
