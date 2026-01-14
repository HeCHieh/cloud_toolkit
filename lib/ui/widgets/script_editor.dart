import 'package:flutter/material.dart';

class ScriptEditor extends StatelessWidget {
  const ScriptEditor({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: 6,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
          ),
          decoration: InputDecoration(
            hintText: hintText ?? '# 每行一条命令\necho "Hello"',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontFamily: 'monospace',
              fontSize: 13,
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
