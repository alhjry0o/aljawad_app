import 'package:flutter_test/flutter_test.dart';
import 'package:aljawad_services/data/datasources/services_catalog.dart';
import 'package:aljawad_services/data/repositories/services_repository.dart';

void main() {
  const repo = LocalServicesRepository();

  test('categories are not empty', () {
    expect(repo.categories(), isNotEmpty);
  });

  test('search returns matching services', () {
    final result = repo.search('تنظيف');
    expect(result, isNotEmpty);
  });

  test('findById returns null for unknown id', () {
    expect(repo.byId('unknown'), isNull);
  });

  test('catalog site types include villa and office', () {
    expect(ServicesCatalog.siteTypeKeys, contains('siteVilla'));
    expect(ServicesCatalog.siteTypeKeys, contains('siteOffice'));
  });
}