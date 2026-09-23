class PortfolioProject {
  const PortfolioProject({
    required this.id,
    required this.categoryKey,
    required this.titleAr,
    required this.titleEn,
    required this.summaryAr,
    required this.summaryEn,
  });

  final String id;
  final String categoryKey; // يطابق معرف فئة الخدمة
  final String titleAr;
  final String titleEn;
  final String summaryAr;
  final String summaryEn;

  String title(bool ar) => ar ? titleAr : titleEn;
  String summary(bool ar) => ar ? summaryAr : summaryEn;
}