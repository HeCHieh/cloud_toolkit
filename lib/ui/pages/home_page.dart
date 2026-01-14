import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../widgets/widgets.dart';
import 'task_form_page.dart';
import 'task_detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Toolkit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(tasksProvider),
            tooltip: '刷新',
          ),
        ],
      ),
      body: tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '还没有部署任务',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () => _navigateToForm(context),
                    icon: const Icon(Icons.add),
                    label: const Text('创建任务'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TaskCard(
                    task: task,
                    onTap: () => _navigateToDetail(context, task.id),
                    onEdit: () => _navigateToForm(context, task: task),
                    onDelete: () => _confirmDelete(context, ref, task.id),
                  ),
                );
              },
            ),
      floatingActionButton: tasks.isNotEmpty
          ? FloatingActionButton(
              onPressed: () => _navigateToForm(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _navigateToForm(BuildContext context, {dynamic task}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormPage(task: task),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String taskId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(taskId: taskId),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: const Text('确定要删除这个部署任务吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(tasksProvider.notifier).delete(taskId);
              Navigator.pop(context);
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
