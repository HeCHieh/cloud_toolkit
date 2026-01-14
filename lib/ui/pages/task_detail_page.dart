import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import '../../data/models/models.dart';
import '../../providers/providers.dart';
import '../widgets/widgets.dart';
import 'log_viewer_page.dart';

class TaskDetailPage extends ConsumerStatefulWidget {
  const TaskDetailPage({super.key, required this.taskId});

  final String taskId;

  @override
  ConsumerState<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends ConsumerState<TaskDetailPage> {
  bool _showLiveLog = false;
  String? _currentExecutionId;
  Timer? _refreshTimer;
  final ScrollController _logScrollController = ScrollController();

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _logScrollController.dispose();
    super.dispose();
  }

  void _startRefreshTimer(String executionId) {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(
      const Duration(milliseconds: 500),
      (_) {
        ref.read(executionRefreshProvider(executionId).notifier).state++;
        _scrollToBottom();
      },
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_logScrollController.hasClients) {
        _logScrollController
            .jumpTo(_logScrollController.position.maxScrollExtent);
      }
    });
  }

  void _stopRefreshTimer() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);
    final task = tasks.firstWhere(
      (t) => t.id == widget.taskId,
      orElse: () => throw StateError('Task not found'),
    );
    final executions = ref.watch(executionsProvider(widget.taskId));
    final executionsNotifier =
        ref.watch(executionsProvider(widget.taskId).notifier);
    final deployState = ref.watch(deployProvider);
    final isRunning = deployState.isRunning(widget.taskId);

    // Track current execution for live log
    if (isRunning) {
      final execId = deployState.currentExecutionIds[widget.taskId];
      if (execId != null && execId != _currentExecutionId) {
        _currentExecutionId = execId;
        _showLiveLog = true;
        _startRefreshTimer(execId);
      }
    } else {
      // Hide live log panel when deployment completes
      if (_showLiveLog) {
        _stopRefreshTimer();
        _showLiveLog = false;
        _currentExecutionId = null;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
        actions: [
          if (isRunning)
            IconButton(
              icon: const Icon(Icons.terminal),
              onPressed: () => setState(() => _showLiveLog = !_showLiveLog),
              tooltip: _showLiveLog ? '隐藏日志' : '显示日志',
            ),
        ],
      ),
      body: Column(
        children: [
          // Live Log Panel
          if (_showLiveLog && _currentExecutionId != null)
            _buildLiveLogPanel(context, _currentExecutionId!),

          // Task Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  context,
                  Icons.dns_outlined,
                  '${task.sshConfig.username}@${task.sshConfig.host}:${task.sshConfig.port}',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  context,
                  Icons.folder_outlined,
                  '${task.localPath} → ${task.remotePath}',
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: deployState.getProgress(widget.taskId),
                        minHeight: 4,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(deployState.getProgress(widget.taskId) * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: isRunning
                      ? null
                      : () => ref.read(deployProvider.notifier).deploy(task),
                  icon: isRunning
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.rocket_launch),
                  label: Text(isRunning ? '部署中...' : '立即部署'),
                ),
              ],
            ),
          ),

          // Execution History Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Text(
                  '执行历史',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  '${executionsNotifier.totalPages} 页 / ${executions.length} 条',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),

          // Execution List
          Expanded(
            child: executions.isEmpty
                ? Center(
                    child: Text(
                      '暂无执行记录',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: executions.length,
                          itemBuilder: (context, index) {
                            final record = executions[index];
                            return _buildExecutionCard(
                              context,
                              record,
                              onDelete: () =>
                                  _confirmDelete(context, record.id),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogViewerPage(
                                    executionId: record.id,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Pagination
                      if (executionsNotifier.hasMore)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: FilledButton.tonal(
                            onPressed: executionsNotifier.loadNextPage,
                            child: const Text('加载更多'),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveLogPanel(BuildContext context, String executionId) {
    final execution = ref.watch(executionDetailProvider(executionId));

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Container(
        color: const Color(0xFF1E1E1E),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black26,
              child: Row(
                children: [
                  const Icon(Icons.terminal, size: 14, color: Colors.green),
                  const SizedBox(width: 8),
                  const Text(
                    '实时日志',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${execution?.logs.length ?? 0} 行',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _logScrollController,
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: SelectableText(
                    execution?.logs.join('\n') ?? '',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: Color(0xFFE0E0E0),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutionCard(
    BuildContext context,
    ExecutionRecord record, {
    required VoidCallback onDelete,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              StatusBadge(status: record.status),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDateTime(record.startTime),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (record.duration != null)
                      Text(
                        '耗时: ${_formatDuration(record.duration!)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                      ),
                    if (record.errorMessage != null)
                      Text(
                        record.errorMessage!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: onDelete,
                color: Theme.of(context).colorScheme.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String executionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除执行记录'),
        content: const Text('确定要删除这条执行记录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(executionRepositoryProvider).delete(executionId);
              ref.read(executionsProvider(widget.taskId).notifier).refresh();
              Navigator.pop(context);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontFamily: 'monospace',
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
