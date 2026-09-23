import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/service_request.dart';
import 'app_providers.dart';

final requestsListProvider = FutureProvider<List<ServiceRequest>>((ref) async {
  final repo = ref.watch(requestsRepositoryProvider);
  return repo.all();
});

final requestByIdProvider =
    FutureProvider.family<ServiceRequest?, String>((ref, id) async {
  final list = await ref.watch(requestsListProvider.future);
  try {
    return list.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
});

/// يُستخدم لتحفيز إعادة الجلب.
class RequestsRefresh extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state = state + 1;
}

final requestsRefreshProvider =
    NotifierProvider<RequestsRefresh, int>(RequestsRefresh.new);