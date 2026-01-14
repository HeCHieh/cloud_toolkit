import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/models.dart';
import '../data/repositories/repositories.dart';

final executionRepositoryProvider = Provider((ref) => ExecutionRepository());

class ExecutionsNotifier extends StateNotifier<List<ExecutionRecord>> {
  final String _taskId;
  final ExecutionRepository _repository;
  int _currentPage = 0;
  int _totalPages = 1;
  bool _hasMore = true;

  ExecutionsNotifier(this._repository, this._taskId) : super([]) {
    _load();
  }

  void _load() {
    final records = _repository.getByTaskIdPaged(_taskId, page: _currentPage);
    _totalPages = _repository.getTotalPages(_taskId);
    _hasMore = _currentPage < _totalPages - 1;
    state = records;
  }

  void refresh() {
    _currentPage = 0;
    _load();
  }

  void loadNextPage() {
    if (!_hasMore || _currentPage >= _totalPages - 1) return;
    _currentPage++;
    final newRecords =
        _repository.getByTaskIdPaged(_taskId, page: _currentPage);
    _hasMore = _currentPage < _totalPages - 1;
    state = [...state, ...newRecords];
  }

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;
  bool get hasMore => _hasMore;
}

final executionsProvider = StateNotifierProvider.family<ExecutionsNotifier,
    List<ExecutionRecord>, String>(
  (ref, taskId) {
    final repository = ref.watch(executionRepositoryProvider);
    return ExecutionsNotifier(repository, taskId);
  },
);

final executionByIdProvider =
    Provider.family<ExecutionRecord?, String>((ref, id) {
  final repository = ref.watch(executionRepositoryProvider);
  return repository.getById(id);
});

final executionRefreshProvider =
    StateProvider.family<int, String>((ref, id) => 0);

final executionDetailProvider =
    Provider.family<ExecutionRecord?, String>((ref, id) {
  ref.watch(executionRefreshProvider(id));
  final repository = ref.watch(executionRepositoryProvider);
  return repository.getById(id);
});
