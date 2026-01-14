import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';

import '../../data/models/models.dart';
import '../../providers/providers.dart';
import '../widgets/widgets.dart';

class TaskFormPage extends ConsumerStatefulWidget {
  const TaskFormPage({super.key, this.task});

  final DeployTask? task;

  @override
  ConsumerState<TaskFormPage> createState() => _TaskFormPageState();
}

class _TaskFormPageState extends ConsumerState<TaskFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _hostController;
  late final TextEditingController _portController;
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _privateKeyPathController;
  late final TextEditingController _passphraseController;
  late final TextEditingController _localPathController;
  late final TextEditingController _remotePathController;
  late final TextEditingController _preScriptController;
  late final TextEditingController _postScriptController;

  bool _usePrivateKey = false;
  bool _isSubmitting = false;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final task = widget.task;

    _nameController = TextEditingController(text: task?.name ?? '');
    _hostController = TextEditingController(text: task?.sshConfig.host ?? '');
    _portController =
        TextEditingController(text: task?.sshConfig.port.toString() ?? '22');
    _usernameController =
        TextEditingController(text: task?.sshConfig.username ?? '');
    _passwordController =
        TextEditingController(text: task?.sshConfig.password ?? '');
    _privateKeyPathController =
        TextEditingController(text: task?.sshConfig.privateKeyPath ?? '');
    _passphraseController =
        TextEditingController(text: task?.sshConfig.passphrase ?? '');
    _localPathController = TextEditingController(text: task?.localPath ?? '');
    _remotePathController = TextEditingController(text: task?.remotePath ?? '');
    _preScriptController = TextEditingController(text: task?.preScript ?? '');
    _postScriptController = TextEditingController(text: task?.postScript ?? '');

    _usePrivateKey = task?.sshConfig.privateKeyPath?.isNotEmpty ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hostController.dispose();
    _portController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _privateKeyPathController.dispose();
    _passphraseController.dispose();
    _localPathController.dispose();
    _remotePathController.dispose();
    _preScriptController.dispose();
    _postScriptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '编辑任务' : '创建任务'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSection('基本信息', [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '任务名称'),
                validator: (v) => v?.isEmpty ?? true ? '请输入任务名称' : null,
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('SSH 配置', [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: _hostController,
                      decoration: const InputDecoration(labelText: '主机地址'),
                      validator: (v) => v?.isEmpty ?? true ? '请输入主机地址' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _portController,
                      decoration: const InputDecoration(labelText: '端口'),
                      keyboardType: TextInputType.number,
                      validator: (v) => v?.isEmpty ?? true ? '请输入端口' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: '用户名'),
                validator: (v) => v?.isEmpty ?? true ? '请输入用户名' : null,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('使用私钥认证'),
                value: _usePrivateKey,
                onChanged: (v) => setState(() => _usePrivateKey = v),
                contentPadding: EdgeInsets.zero,
              ),
              if (_usePrivateKey) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _privateKeyPathController,
                        decoration: const InputDecoration(labelText: '私钥路径'),
                        validator: (v) => _usePrivateKey && (v?.isEmpty ?? true)
                            ? '请选择私钥文件'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: IconButton(
                        onPressed: _pickPrivateKey,
                        icon: const Icon(Icons.folder_open),
                        tooltip: '选择文件',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passphraseController,
                  decoration: const InputDecoration(labelText: '密钥密码 (可选)'),
                  obscureText: true,
                ),
              ] else ...[
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: '密码'),
                  obscureText: true,
                  validator: (v) =>
                      !_usePrivateKey && (v?.isEmpty ?? true) ? '请输入密码' : null,
                ),
              ],
            ]),
            const SizedBox(height: 24),
            _buildSection('路径配置', [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _localPathController,
                      decoration: const InputDecoration(labelText: '本地路径'),
                      validator: (v) => v?.isEmpty ?? true ? '请输入本地路径' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: IconButton(
                      onPressed: _pickLocalPath,
                      icon: const Icon(Icons.folder_open),
                      tooltip: '选择目录',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _remotePathController,
                decoration: const InputDecoration(labelText: '远程路径'),
                validator: (v) => v?.isEmpty ?? true ? '请输入远程路径' : null,
              ),
            ]),
            const SizedBox(height: 24),
            _buildSection('脚本配置 (可选)', [
              ScriptEditor(
                controller: _preScriptController,
                label: '上传前脚本',
                hintText: '# 上传前执行的命令\ncd /app && git pull',
              ),
              const SizedBox(height: 16),
              ScriptEditor(
                controller: _postScriptController,
                label: '上传后脚本',
                hintText: '# 上传后执行的命令\ncd /app && npm run build',
              ),
            ]),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditing ? '保存' : '创建'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Future<void> _pickPrivateKey() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      _privateKeyPathController.text = result.files.first.path ?? '';
    }
  }

  Future<void> _pickLocalPath() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择路径类型'),
        content: const Text('请选择要选择的类型'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'file'),
            child: const Text('选择文件'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, 'directory'),
            child: const Text('选择文件夹'),
          ),
        ],
      ),
    );

    if (result == null) return; // User cancelled

    if (result == 'file') {
      final fileResult = await FilePicker.platform.pickFiles(
        dialogTitle: '选择本地文件',
        allowMultiple: false,
      );
      if (fileResult != null && fileResult.files.isNotEmpty) {
        _localPathController.text = fileResult.files.first.path ?? '';
      }
    } else {
      final dirResult = await FilePicker.platform.getDirectoryPath(
        dialogTitle: '选择本地文件夹',
      );
      if (dirResult != null) {
        _localPathController.text = dirResult;
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final sshConfig = SshConfig(
        host: _hostController.text,
        port: int.parse(_portController.text),
        username: _usernameController.text,
        password: _usePrivateKey ? null : _passwordController.text,
        privateKeyPath: _usePrivateKey ? _privateKeyPathController.text : null,
        passphrase: _usePrivateKey ? _passphraseController.text : null,
      );

      if (_isEditing) {
        final updated = widget.task!.copyWith(
          name: _nameController.text,
          sshConfig: sshConfig,
          localPath: _localPathController.text,
          remotePath: _remotePathController.text,
          preScript: _preScriptController.text.isEmpty
              ? null
              : _preScriptController.text,
          postScript: _postScriptController.text.isEmpty
              ? null
              : _postScriptController.text,
        );
        await ref.read(tasksProvider.notifier).update(updated);
      } else {
        await ref.read(tasksProvider.notifier).create(
              name: _nameController.text,
              sshConfig: sshConfig,
              localPath: _localPathController.text,
              remotePath: _remotePathController.text,
              preScript: _preScriptController.text.isEmpty
                  ? null
                  : _preScriptController.text,
              postScript: _postScriptController.text.isEmpty
                  ? null
                  : _postScriptController.text,
            );
      }

      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
}
