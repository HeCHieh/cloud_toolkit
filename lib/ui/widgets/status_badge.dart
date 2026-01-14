import 'package:flutter/material.dart';

import '../../data/models/models.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final ExecutionStatus status;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (Color bg, Color fg, String label) = switch (status) {
      ExecutionStatus.pending => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer,
          '等待中',
        ),
      ExecutionStatus.running => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer,
          '运行中',
        ),
      ExecutionStatus.success => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer,
          '成功',
        ),
      ExecutionStatus.failed => (
          colorScheme.errorContainer,
          colorScheme.onErrorContainer,
          '失败',
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
