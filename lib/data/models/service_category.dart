import 'service.dart';

class ServiceCategory {
  const ServiceCategory({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.services,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final List<Service> services;

  String name(bool ar) => ar ? nameAr : nameEn;
}