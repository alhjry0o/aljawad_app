import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/portfolio_project.dart';
import '../../data/models/service.dart';
import '../../data/models/service_category.dart';
import 'app_providers.dart';

final categoriesProvider = Provider<List<ServiceCategory>>((ref) {
  return ref.watch(servicesRepositoryProvider).categories();
});

final serviceByIdProvider =
    Provider.family<Service?, String>((ref, id) {
  return ref.watch(servicesRepositoryProvider).byId(id);
});

class ServicesQuery {
  const ServicesQuery({this.q = '', this.categoryId});
  final String q;
  final String? categoryId;

  ServicesQuery copyWith({String? q, String? categoryId, bool clearCategory = false}) =>
      ServicesQuery(
        q: q ?? this.q,
        categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      );
}

final servicesQueryProvider = StateProvider<ServicesQuery>(
  (ref) => const ServicesQuery(),
);

final filteredServicesProvider = Provider<List<Service>>((ref) {
  final q = ref.watch(servicesQueryProvider);
  return ref
      .watch(servicesRepositoryProvider)
      .search(q.q, categoryId: q.categoryId);
});

final portfolioFilterProvider = StateProvider<String?>((ref) => null);

final portfolioProvider = Provider<List<PortfolioProject>>((ref) {
  final c = ref.watch(portfolioFilterProvider);
  return ref.watch(servicesRepositoryProvider).portfolio(categoryId: c);
});