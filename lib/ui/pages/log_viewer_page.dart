import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../data/models/models.dart';
import '../../providers/providers.dart';

class LogViewerPage extends ConsumerStatefulWidget {
  const LogViewerPage({
    super.key,
    required this.executionId,
    this.autoRefresh = false,
  });

  final String executionId;
  final bool autoRefresh;

  @override
  ConsumerState<LogViewerPage> createState() => _LogViewerPageState();
}

class _LogViewerPageState extends ConsumerState<LogViewerPage> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    if (widget.autoRefresh) {
      _refreshTimer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => _refreshLogs(),
      );
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _refreshLogs() {
    ref.read(executionRefreshProvider(widget.executionId).notifier).state++;
  }

  @override
  Widget build(BuildContext context) {
    final execution = ref.watch(executionDetailProvider(widget.executionId));
    final isRunning = execution?.status == ExecutionStatus.running;

    return Scaffold(
      appBar: AppBar(
        title: const Text('执行日志'),
        actions: [
          if (isRunning)
            Padding(
              padding: const EdgeInsets.all(8),
              child: FilledButton.tonal(
                onPressed: () => _refreshLogs(),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 4),
                    Text('刷新'),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: execution == null
          ? const Center(child: Text('未找到执行记录'))
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Row(
                    children: [
                      _buildStatusChip(context, execution.status.name),
                      const SizedBox(width: 16),
                      Text(
                        '开始: ${_formatDateTime(execution.startTime)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (execution.endTime != null) ...[
                        const SizedBox(width: 16),
                        Text(
                          '耗时: ${_formatDuration(execution.duration!)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                      if (isRunning) ...[
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                width: 8,
                                height: 8,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '运行中',
                                style: TextStyle(fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (execution.errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Text(
                      execution.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onErrorContainer,
                        fontFamily: 'monospace',
                        fontSize: 13,
                      ),
                    ),
                  ),
                Expanded(
                  child: Container(
                    color: const Color(0xFF1E1E1E),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      controller: ScrollController(),
                      child: SelectableText(
                        execution.logs.join('\n'),
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 13,
                          color: Color(0xFFE0E0E0),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String status) {
    final colorScheme = Theme.of(context).colorScheme;
    final (Color bg, Color fg) = switch (status) {
      'pending' => (
          colorScheme.secondaryContainer,
          colorScheme.onSecondaryContainer
        ),
      'running' => (
          colorScheme.primaryContainer,
          colorScheme.onPrimaryContainer
        ),
      'success' => (
          colorScheme.tertiaryContainer,
          colorScheme.onTertiaryContainer
        ),
      'failed' => (colorScheme.errorContainer, colorScheme.onErrorContainer),
      _ => (colorScheme.surfaceContainerHighest, colorScheme.onSurface),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration d) {
    if (d.inHours > 0) {
      return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    } else if (d.inMinutes > 0) {
      return '${d.inMinutes}m ${d.inSeconds.remainder(60)}s';
    } else {
      return '${d.inSeconds}s';
    }
  }
}
