import '../datasources/portfolio_data.dart';
import '../datasources/services_catalog.dart';
import '../models/portfolio_project.dart';
import '../models/service.dart';
import '../models/service_category.dart';

abstract class ServicesRepository {
  List<ServiceCategory> categories();
  List<Service> search(String query, {String? categoryId});
  Service? byId(String id);
  ServiceCategory? categoryOf(String serviceId);
  List<PortfolioProject> portfolio({String? categoryId});
}

class LocalServicesRepository implements ServicesRepository {
  const LocalServicesRepository();

  @override
  List<ServiceCategory> categories() => ServicesCatalog.categories;

  @override
  List<Service> search(String query, {String? categoryId}) {
    final q = query.trim().toLowerCase();
    final all = <Service>[];
    for (final c in ServicesCatalog.categories) {
      if (categoryId != null && c.id != categoryId) continue;
      all.addAll(c.services);
    }
    if (q.isEmpty) return all;
    return all.where((s) {
      return s.nameAr.toLowerCase().contains(q) ||
          s.nameEn.toLowerCase().contains(q) ||
          s.shortAr.toLowerCase().contains(q) ||
          s.shortEn.toLowerCase().contains(q) ||
          s.featuresAr.any((f) => f.toLowerCase().contains(q)) ||
          s.featuresEn.any((f) => f.toLowerCase().contains(q));
    }).toList();
  }

  @override
  Service? byId(String id) => ServicesCatalog.findById(id);

  @override
  ServiceCategory? categoryOf(String serviceId) =>
      ServicesCatalog.categoryOf(serviceId);

  @override
  List<PortfolioProject> portfolio({String? categoryId}) {
    if (categoryId == null) return PortfolioData.projects;
    return PortfolioData.projects
        .where((p) => p.categoryKey == categoryId)
        .toList();
  }
}