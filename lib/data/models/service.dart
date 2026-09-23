class Service {
  const Service({
    required this.id,
    required this.categoryId,
    required this.nameAr,
    required this.nameEn,
    required this.shortAr,
    required this.shortEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.featuresAr,
    required this.featuresEn,
    required this.sitesAr,
    required this.sitesEn,
  });

  final String id;
  final String categoryId;
  final String nameAr;
  final String nameEn;
  final String shortAr;
  final String shortEn;
  final String descriptionAr;
  final String descriptionEn;
  final List<String> featuresAr;
  final List<String> featuresEn;
  final List<String> sitesAr;
  final List<String> sitesEn;

  String name(bool ar) => ar ? nameAr : nameEn;
  String short(bool ar) => ar ? shortAr : shortEn;
  String description(bool ar) => ar ? descriptionAr : descriptionEn;
  List<String> features(bool ar) => ar ? featuresAr : featuresEn;
  List<String> sites(bool ar) => ar ? sitesAr : sitesEn;
}